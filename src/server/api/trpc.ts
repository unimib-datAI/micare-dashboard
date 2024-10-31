/**
 * YOU PROBABLY DON'T NEED TO EDIT THIS FILE, UNLESS:
 * 1. You want to modify request context (see Part 1).
 * 2. You want to create a new middleware or type of procedure (see Part 3).
 *
 * TL;DR - This is where all the tRPC server stuff is created and plugged in. The pieces you will
 * need to use are documented accordingly near the end.
 */

/**
 * 1. CONTEXT
 *
 * This section defines the "contexts" that are available in the backend API.
 *
 * These allow you to access things when processing a request, like the database, the session, etc.
 */
/**
 * 2. INITIALIZATION
 *
 * This is where the tRPC API is initialized, connecting the context and transformer. We also parse
 * ZodErrors so that you get typesafety on the frontend if your procedure fails due to validation
 * errors on the backend.
 */
import { type inferRouterInputs, initTRPC, TRPCError } from '@trpc/server';
import { type CreateNextContextOptions } from '@trpc/server/adapters/next';
import { type Session } from 'next-auth';
import superjson from 'superjson';
import { ZodError } from 'zod';

import { env } from '@/env.mjs';
import type { AppRouter } from '@/server/api/root';
import { getServerAuthSession } from '@/server/auth';
import { prisma } from '@/server/db';
import { Keycloak } from '@/utils/keycloak';
import * as logger from '@/utils/logger';

type CreateContextOptions = {
  session: Session | null;
};

export type Meta = {
  doLog: boolean;
  createResource: boolean;
};

type RouterInput = inferRouterInputs<AppRouter>;

type Routes =
  | 'Administration'
  | 'User'
  | 'Patient'
  | 'Therapist'
  | 'Note'
  | 'Tag';
type Procedures =
  | keyof RouterInput['administration']
  | keyof RouterInput['user']
  | keyof RouterInput['patient']
  | keyof RouterInput['therapist']
  | keyof RouterInput['note']
  | keyof RouterInput['tag'];

type InputType = {
  where: {
    id: string | number;
  };
  data: {
    id: string | number;
  };
};

type OutputType = {
  id: string | number;
  patients?: [
    {
      id: string | number;
    }
  ];
};

/**
 * Keycloak client initialization
 */
const keycloak = new Keycloak({
  clientId: env.NEXT_PUBLIC_KEYCLOAK_CLIENT_ID,
  clientSecret: env.CLIENT_SECRET,
  host: env.NEXT_PUBLIC_KEYCLOAK_FRONTEND_URL,
  realm: env.NEXT_PUBLIC_KEYCLOAK_REALM,
});

Object.freeze(keycloak);

function hasPatient(obj: unknown): obj is { patients: unknown[] } {
  return (
    typeof obj === 'object' &&
    obj !== null &&
    'patients' in obj &&
    Array.isArray(obj.patients)
  );
}

/**
 * This helper generates the "internals" for a tRPC context. If you need to use it, you can export
 * it from here.
 *
 * Examples of things you may need it for:
 * - testing, so we don't have to mock Next.js' req/res
 * - tRPC's `createSSGHelpers`, where we don't have req/res
 *
 * @see https://create.t3.gg/en/usage/trpc#-servertrpccontextts
 */
const createInnerTRPCContext = (opts: CreateContextOptions) => {
  return {
    session: opts.session,
    prisma,
  };
};

/**
 * This is the actual context you will use in your router. It will be used to process every request
 * that goes through your tRPC endpoint.
 *
 * @see https://trpc.io/docs/context
 */
export const createTRPCContext = async (opts: CreateNextContextOptions) => {
  const { req, res } = opts;

  // Get the session from the server using the getServerSession wrapper function
  const session = await getServerAuthSession({ req, res });

  return createInnerTRPCContext({
    session,
  });
};

const t = initTRPC
  .context<typeof createTRPCContext>()
  .meta<Meta>()
  .create({
    transformer: superjson,
    errorFormatter({ shape, error }) {
      return {
        ...shape,
        data: {
          ...shape.data,
          zodError:
            error.cause instanceof ZodError ? error.cause.flatten() : null,
        },
      };
    },
    defaultMeta: {
      doLog: true,
      createResource: true,
    },
  });

/**
 * 3. ROUTER & PROCEDURE (THE IMPORTANT BIT)
 *
 * These are the pieces you use to build your tRPC API. You should import these a lot in the
 * "/src/server/api/routers" directory.
 */

/**
 * This is how you create new routers and sub-routers in your tRPC API.
 *
 * @see https://trpc.io/docs/router
 */
export const createTRPCRouter = t.router;

/**
 * Public (unauthenticated) procedure
 *
 * This is the base piece you use to build new queries and mutations on your tRPC API. It does not
 * guarantee that a user querying is authorized, but you can still access user session data if they
 * are logged in.
 */
export const publicProcedure = t.procedure;

const capitalize = (s: string) => {
  if (typeof s !== 'string') return '';
  return s.charAt(0).toUpperCase() + s.slice(1);
};

/** Reusable middleware that enforces users are logged in before running the procedure. */
/**
 * check middleware @see https://trpc.io/docs/server/middleware
 */
const getAction = (action: string) => {
  switch (action) {
    case 'findMany':
      return 'READALL' as logger.Action;
    case 'findUnique':
      return 'READ' as logger.Action;
    case 'create':
      return 'CREATE' as logger.Action;
    case 'update':
      return 'UPDATE' as logger.Action;
    case 'delete':
      return 'DELETE' as logger.Action;
    default:
      return 'OTHER' as logger.Action;
  }
};

const enforceUserIsAuthed = t.middleware(
  async ({ ctx, next, path, meta, input }) => {
    if (
      !ctx.session ||
      !ctx.session.user ||
      !ctx.session.user.group ||
      !ctx.session.user.id
    ) {
      throw new TRPCError({ code: 'UNAUTHORIZED' });
    }

    const model = capitalize(path).split('.')[0] as Routes;
    const action = path.split('.')[1] as Procedures;

    const typedInput = input as InputType;
    const owner = typedInput?.where?.id
      ? await logger.getUserById(typedInput.where.id.toString(), ctx)
      : ctx.session.user;

    if (
      (model === 'User' && action === 'checkAvailability') ||
      meta?.createResource === false
    ) {
      return next({
        ctx: {
          // infers the `session` as non-nullable
          session: {
            ...ctx.session,
            user: ctx.session.user,
            group: ctx.session.user.group,
          },
        },
      });
    }

    const user = ctx.session.user;
    if (action === 'delete' || action === 'update') {
      const kcGet = await keycloak.resource.search({
        scope: ctx.session.user.group
          .map((this_group) => {
            return this_group;
          })
          .join('&scope='),
        type: model,
      });

      if (!kcGet) {
        logger.doLog({
          resource: model,
          user: user,
          owner: owner,
          action: getAction(action),
          result: 'OTHER',
        });
        throw new TRPCError({
          code: 'UNAUTHORIZED',
          message: 'Error getting resource from keycloak',
        });
      }

      if (!kcGet.includes(typedInput.where.id.toString())) {
        logger.doLog({
          resource: model,
          user: user,
          owner: owner,
          action: getAction(action),
          result: 'DENIED',
        });
        throw new TRPCError({
          code: 'UNAUTHORIZED',
          message: `User does not have permission to ${action} ${model} because it does not own it`,
        });
      }

      logger.doLog({
        resource: model,
        user: user,
        owner: owner,
        action: getAction(action),
        result: 'GRANTED',
      });
    }

    const result = await next({
      ctx: {
        // infers the `session` as non-nullable
        session: {
          ...ctx.session,
          user: ctx.session.user,
          group: ctx.session.user.group,
        },
      },
    });

    if (!result.ok) {
      logger.doLog({
        resource: model,
        user: user,
        owner: owner,
        action: getAction(action),
        result: 'OTHER',
      });
      throw new TRPCError(result.error);
    }

    const returnData = result.data as OutputType[] | OutputType;

    if (!returnData) {
      throw new TRPCError({
        code: 'INTERNAL_SERVER_ERROR',
        message: 'No data returned from query',
      });
    }

    if (model === 'Therapist' && action === 'findUnique') {
      const ownedPatients = await keycloak.resource.search({
        scope: ctx.session.user.group
          .map((this_group) => {
            return this_group;
          })
          .join('&scope='),
        type: 'Patient',
      });

      console.log({ '==========Owned Patient==========': ownedPatients });

      if (
        !Array.isArray(returnData) &&
        returnData?.patients &&
        hasPatient(result.data)
      ) {
        const allowedData = returnData.patients.filter((this_data) => {
          if (!('id' in this_data)) return false;
          if (ownedPatients.includes(this_data.id.toString())) {
            logger.doLog({
              resource: model + '/' + this_data.id.toString(),
              user: user,
              owner: owner,
              action: getAction(action),
              result: 'GRANTED',
            });
            return this_data;
          } else {
            logger.doLog({
              resource: model + '/' + this_data.id.toString(),
              user: user,
              owner: owner,
              action: getAction(action),
              result: 'DENIED',
            });
            return false;
          }
        });

        console.log({ '==========Allowed Data==========': allowedData });

        // if (allowedData.length > 0 && hasPatient(result.data)) {
        //   result.data.patients = allowedData;
        //   return result;
        // }
        if (allowedData == result.data.patients) {
          logger.doLog({
            resource: model,
            user: user,
            owner: owner,
            action: getAction(action),
            result: 'GRANTED',
          });
        } else {
          logger.doLog({
            resource: model,
            user: user,
            owner: owner,
            action: getAction(action),
            result: 'DENIED',
          });
        }

        result.data.patients = allowedData;
        return result;
      }

      return next({
        ctx: {
          // infers the `session` as non-nullable
          session: {
            ...ctx.session,
            user: ctx.session.user,
            group: ctx.session.user.group,
          },
        },
      });
    }

    if (Array.isArray(returnData)) {
      const kcGet = await keycloak.resource.search({
        scope: ctx.session.user.group
          .map((this_group) => {
            return this_group;
          })
          .join('&scope='),
        type: model,
      });

      const allowedData = returnData.filter((this_data) => {
        if (!('id' in this_data)) return false;
        if (kcGet.includes(this_data.id.toString())) {
          logger.doLog({
            resource: model + '/' + this_data.id.toString(),
            user: user,
            owner: owner,
            action: getAction(action),
            result: 'GRANTED',
          });
          return this_data;
        } else {
          logger.doLog({
            resource: model + '/' + this_data.id.toString(),
            user: user,
            owner: owner,
            action: getAction(action),
            result: 'DENIED',
          });
          return false;
        }
      });

      if (allowedData.length > 0) {
        result.data = allowedData;
        return result;
      }
      logger.doLog({
        resource: model,
        user: user,
        owner: owner,
        action: getAction(action),
        result: 'OTHER',
      });
      throw new TRPCError({
        code: 'UNAUTHORIZED',
        message: `User does not have permission to ${action} ${model}`,
      });
    }

    if (action === 'create') {
      const data = {
        _id: returnData.id,
        name: returnData.id.toString(),
        type: model,
        resource_scopes: ctx.session.user.group.map((this_group) => {
          return this_group;
        }),
      };

      const kcCreated = await keycloak.resource.create(data);

      if (!kcCreated) {
        logger.doLog({
          resource: model + '/' + returnData.id.toString(),
          user: user,
          owner: owner,
          action: getAction(action),
          result: 'DENIED',
        });
        throw new TRPCError({
          code: 'UNAUTHORIZED',
          message: 'Error creating resource in keycloak',
        });
      }

      logger.doLog({
        resource: model + '/' + returnData.id.toString(),
        user: user,
        owner: owner,
        action: getAction(action),
        result: 'GRANTED',
      });

      return result;
    }

    throw new TRPCError({
      code: 'UNAUTHORIZED',
      message: `User does not have permission to ${action} ${model}`,
    });
  }
);

/**
 * Protected (authenticated) procedure
 *
 * If you want a query or mutation to ONLY be accessible to logged in users, use this. It verifies
 * the session is valid and guarantees `ctx.session.user` is not null.
 *
 * @see https://trpc.io/docs/procedures
 */
export const protectedProcedure = t.procedure
  .use(enforceUserIsAuthed)
  .meta({ doLog: false, createResource: false });

//type RouterOutput = inferRouterOutputs<AppRouter>;

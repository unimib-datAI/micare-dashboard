import { type Prisma, type PrismaClient, type Session } from '@prisma/client';
import { type DefaultArgs } from '@prisma/client/runtime/library';
import { type TRPCClientErrorLike } from '@trpc/client';
import {
  type BuildProcedure,
  type RootConfig,
  type unsetMarker,
} from '@trpc/server';
import {
  type TRPC_ERROR_CODE_KEY,
  type TRPC_ERROR_CODE_NUMBER,
} from '@trpc/server/rpc';
import { type ISODateString } from 'next-auth';
import type SuperJSON from 'superjson';
import { type typeToFlattenedError } from 'zod';

import { type Meta } from '@/server/api/trpc';

export type TData = {
  id: string;
  patientId: string;
  date: Date;
  type: string;
  records: Prisma.JsonValue;
  medicalRecordId: string;
  T: number | null;
};

export type TVariables = Prisma.AdministrationCreateArgs<DefaultArgs>;

export type TContext = unknown;

export type TError = TRPCClientErrorLike<
  BuildProcedure<
    'mutation',
    {
      _config: RootConfig<{
        ctx: {
          session: Session | null;
          prisma: PrismaClient<Prisma.PrismaClientOptions, never, DefaultArgs>;
        };
        meta: Meta;
        errorShape: {
          data: {
            zodError: typeToFlattenedError<any, string> | null;
            code: TRPC_ERROR_CODE_KEY;
            httpStatus: number;
            path?: string;
            stack?: string;
          };
          message: string;
          code: TRPC_ERROR_CODE_NUMBER;
        };
        transformer: typeof SuperJSON;
      }>;
      _meta: Meta;
      _ctx_out: {
        session: {
          user: {
            id: string;
            email: string;
            roles: string[];
            group: string[];
          };
          group: string[];
          token: {
            access_token: string;
            expires_at: number;
            refresh_token: string;
          };
          error: string;
          expires: ISODateString;
        };
        prisma: PrismaClient<Prisma.PrismaClientOptions, never, DefaultArgs>;
      };
      _input_in: Prisma.AdministrationCreateArgs<DefaultArgs>;
      _input_out: Prisma.AdministrationCreateArgs<DefaultArgs>;
      _output_in: typeof unsetMarker;
      _output_out: typeof unsetMarker;
    },
    {
      id: string;
      patientId: string;
      date: Date;
      type: string;
      records: Prisma.JsonValue;
      medicalRecordId: string;
      T: number | null;
    }
  >
>;

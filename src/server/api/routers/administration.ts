import { TRPCError } from '@trpc/server';
import {
  AdministrationCreateArgsSchema,
  AdministrationDeleteArgsSchema,
  AdministrationFindManyArgsSchema,
  AdministrationFindUniqueArgsSchema,
  AdministrationUpdateArgsSchema,
} from 'prisma/generated/zod';

import { createTRPCRouter, protectedProcedure } from '@/server/api/trpc';

export const administrationsRouter = createTRPCRouter({
  findUnique: protectedProcedure
    .meta({ createResource: false, doLog: false })
    .input(AdministrationFindUniqueArgsSchema)
    .query(async ({ input, ctx }) => {
      const administration = await ctx.prisma.administration.findUnique(input);
      if (!administration || !administration.records) {
        throw new TRPCError({
          message: 'Administration not found',
          code: 'NOT_FOUND',
        });
      }

      return { administration };
    }),

  findMany: protectedProcedure
    .meta({ createResource: false, doLog: false })
    .input(AdministrationFindManyArgsSchema)
    .query(async ({ input, ctx }) => {
      const administrations = await ctx.prisma.administration.findMany(input);

      return administrations;
    }),

  create: protectedProcedure
    .meta({ createResource: false, doLog: false })
    .input(AdministrationCreateArgsSchema)
    .mutation(async ({ input, ctx }) => {
      const { type } = input.data;

      const T = await ctx.prisma.administration.count({
        where: { patientId: input.data.patientId, type },
      });

      input.data.T = T;

      const administration = await ctx.prisma.administration.create(input);

      return administration;
    }),

  update: protectedProcedure
    .meta({ createResource: false, doLog: false })
    .input(AdministrationUpdateArgsSchema)
    .mutation(async ({ input, ctx }) => {
      const administration = await ctx.prisma.administration.update(input);

      return administration;
    }),

  delete: protectedProcedure
    .meta({ createResource: false, doLog: false })
    .input(AdministrationDeleteArgsSchema)
    .mutation(async ({ input, ctx }) => {
      const administration = await ctx.prisma.administration.delete(input);

      return administration;
    }),
});

import { UserFindUniqueArgsSchema } from 'prisma/generated/zod';

import { createTRPCRouter, protectedProcedure } from '@/server/api/trpc';

export const userRouter = createTRPCRouter({
  checkAvailability: protectedProcedure
    .meta({
      doLog: false,
      createResource: true,
    })
    .input(UserFindUniqueArgsSchema)
    .query(async ({ input, ctx }) => {
      const patient = await ctx.prisma.user.findUnique(input);

      return !patient; // return true if patient is not found
    }),

  findUnique: protectedProcedure
    .meta({
      doLog: false,
      createResource: false,
    })
    .input(UserFindUniqueArgsSchema)
    .query(async ({ input, ctx }) => {
      const user = await ctx.prisma.user.findUnique(input);

      return user;
    }),
});

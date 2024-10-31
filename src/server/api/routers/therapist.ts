import { UserUpdateArgsSchema } from 'prisma/generated/zod';

import { createTRPCRouter, protectedProcedure } from '@/server/api/trpc';

export const therapistRouter = createTRPCRouter({
  findUnique: protectedProcedure.query(async ({ ctx }) => {
    const therapist = await ctx.prisma.therapist.findUnique({
      where: { id: ctx.session.user.id },
      include: {
        notes: true,
        tags: true,
        user: true,
        patients: {
          orderBy: {
            user: {
              name: 'asc',
            },
          },
          include: {
            user: true,
            medicalRecord: {
              include: {
                anamnesticData: true,
                clinicalData: true,
                intervention: true,
              },
            },
            tags: true,
          },
        },
      },
    });

    return therapist;
  }),
  update: protectedProcedure
    .input(UserUpdateArgsSchema)
    .mutation(async ({ input, ctx }) => {
      const userProfile = await ctx.prisma.user.update(input);
      return userProfile;
    }),
});

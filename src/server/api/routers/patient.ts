import {
  PatientCreateWithoutTherapistInputSchema,
  PatientDeleteArgsSchema,
  PatientUpdateArgsSchema,
  UserFindUniqueArgsSchema,
} from 'prisma/generated/zod';

import { createTRPCRouter, protectedProcedure } from '@/server/api/trpc';

export const patientRouter = createTRPCRouter({
  create: protectedProcedure
    .meta({ createResource: false, doLog: false })
    .input(PatientCreateWithoutTherapistInputSchema)
    .mutation(async ({ input, ctx }) => {
      const therapistId = ctx.session.user.id;
      const patient = await ctx.prisma.patient.create({
        data: {
          ...input,
          therapist: {
            connect: {
              id: therapistId,
            },
          },
        },
      });

      return patient;
    }),

  findUnique: protectedProcedure
    .meta({ createResource: false, doLog: false })
    .input(UserFindUniqueArgsSchema)
    .query(async ({ input, ctx }) => {
      const user = await ctx.prisma.user.findUnique({
        where: input.where,
        include: {
          patient: {
            include: {
              medicalRecord: {
                include: {
                  anamnesticData: true,
                  clinicalData: true,
                  intervention: true,
                  administrations: {
                    orderBy: {
                      date: 'desc',
                    },
                  },
                },
              },
              user: true,
              tags: true,
            },
          },
        },
      });

      return user?.patient;
    }),

  update: protectedProcedure
    .meta({ createResource: false, doLog: false })
    .input(PatientUpdateArgsSchema)
    .mutation(async ({ input, ctx }) => {
      const patient = await ctx.prisma.patient.update(input);

      return patient;
    }),

  delete: protectedProcedure
    .meta({ createResource: false, doLog: false })
    .input(PatientDeleteArgsSchema)
    .mutation(async ({ input, ctx }) => {
      const patient = await ctx.prisma.patient.delete(input);

      return patient;
    }),
});

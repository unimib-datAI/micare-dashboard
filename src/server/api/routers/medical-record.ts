import {
  MedicalRecordFindUniqueArgsSchema,
  MedicalRecordUpdateArgsSchema,
} from 'prisma/generated/zod/index';

import { createTRPCRouter, protectedProcedure } from '@/server/api/trpc';

export const medicalRecordRouter = createTRPCRouter({
  findUnique: protectedProcedure
    .meta({ createResource: false, doLog: false })
    .input(MedicalRecordFindUniqueArgsSchema)
    .query(async ({ ctx, input }) => {
      const medicalRecords = await ctx.prisma.medicalRecord.findUnique(input);

      return medicalRecords;
    }),

  update: protectedProcedure
    .meta({ createResource: false, doLog: false })
    .input(MedicalRecordUpdateArgsSchema)
    .mutation(async ({ ctx, input }) => {
      const medicalRecords = await ctx.prisma.medicalRecord.update(input);

      return medicalRecords;
    }),
});

import { administrationsRouter } from '@/server/api/routers/administration';
import { medicalRecordRouter } from '@/server/api/routers/medical-record';
import { notesRouter } from '@/server/api/routers/notes';
import { patientRouter } from '@/server/api/routers/patient';
import { tagsRouter } from '@/server/api/routers/tags';
import { therapistRouter } from '@/server/api/routers/therapist';
import { userRouter } from '@/server/api/routers/user';
import { createTRPCRouter } from '@/server/api/trpc';

/**
 * This is the primary router for your server.
 *
 * All routers added in /api/routers should be manually added here.
 */
export const appRouter = createTRPCRouter({
  therapist: therapistRouter,
  patient: patientRouter,
  user: userRouter,
  note: notesRouter,
  tag: tagsRouter,
  administration: administrationsRouter,
  medicalRecord: medicalRecordRouter,
});

// export type definition of API
export type AppRouter = typeof appRouter;

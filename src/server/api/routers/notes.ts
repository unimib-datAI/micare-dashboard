import {
  NoteCreateArgsSchema,
  NoteDeleteArgsSchema,
  NoteFindManyArgsSchema,
  NoteUpdateArgsSchema,
} from 'prisma/generated/zod';

import { createTRPCRouter, protectedProcedure } from '@/server/api/trpc';

export const notesRouter = createTRPCRouter({
  findMany: protectedProcedure
    .meta({ createResource: false, doLog: false })
    .input(NoteFindManyArgsSchema)
    .query(async ({ input, ctx }) => {
      const notes = await ctx.prisma.note.findMany(input);

      return notes;
    }),

  create: protectedProcedure
    .meta({ createResource: false, doLog: false })
    .input(NoteCreateArgsSchema)
    .mutation(async ({ input, ctx }) => {
      const note = await ctx.prisma.note.create(input);

      return note;
    }),

  update: protectedProcedure
    .meta({ createResource: false, doLog: false })
    .input(NoteUpdateArgsSchema)
    .mutation(async ({ input, ctx }) => {
      const note = await ctx.prisma.note.update(input);

      return note;
    }),

  delete: protectedProcedure
    .meta({ createResource: false, doLog: false })
    .input(NoteDeleteArgsSchema)
    .mutation(async ({ input, ctx }) => {
      const note = await ctx.prisma.note.delete(input);

      return note;
    }),
});

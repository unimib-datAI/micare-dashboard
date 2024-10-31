import {
  TagCreateArgsSchema,
  TagDeleteArgsSchema,
  TagFindManyArgsSchema,
  TagUpdateArgsSchema,
} from 'prisma/generated/zod';

import { createTRPCRouter, protectedProcedure } from '@/server/api/trpc';

export const tagsRouter = createTRPCRouter({
  findMany: protectedProcedure
    .input(TagFindManyArgsSchema)
    .query(async ({ input, ctx }) => {
      const tags = await ctx.prisma.tag.findMany(input);

      return tags;
    }),

  create: protectedProcedure
    .input(TagCreateArgsSchema)
    .mutation(async ({ input, ctx }) => {
      const tag = await ctx.prisma.tag.create(input);

      return tag;
    }),

  update: protectedProcedure
    .input(TagUpdateArgsSchema)
    .mutation(async ({ input, ctx }) => {
      // const id = input.id;
      // delete input.id;
      const tag = await ctx.prisma.tag.update(input);

      return tag;
    }),

  delete: protectedProcedure
    .input(TagDeleteArgsSchema)
    .mutation(async ({ input, ctx }) => {
      const tag = await ctx.prisma.tag.delete(input);

      return tag;
    }),
});

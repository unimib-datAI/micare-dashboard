import { type PrismaClient } from '@prisma/client';

import { type Adapter } from '@/types/adapter';

export const PrismaAdapter = (prisma: PrismaClient): Adapter => {
  return {
    async createUser(user) {
      const platformRole = user.roles.includes('therapist')
        ? 'therapist'
        : 'patient';

      return prisma.user.create({
        data: {
          ...user,
          [platformRole]: {
            create: {},
          },
        },
      });
    },
    getUser: (id) => prisma.user.findUnique({ where: { id } }),
    getUserByEmail: (email) => prisma.user.findUnique({ where: { email } }),
    async getUserByAccount(providerAccountId) {
      const account = await prisma.account.findUnique({
        where: {
          provider: providerAccountId.provider,
          providerAccountId: providerAccountId.providerAccountId,
        },
        select: { user: true },
      });

      const user = account?.user ?? null;

      return user;
    },
    updateUser: ({ id, ...data }) =>
      prisma.user.update({ where: { id }, data }),
    deleteUser: (id) => prisma.user.delete({ where: { id } }),
    linkAccount: async (data) => {
      await prisma.account.create({
        data: {
          type: data.type,
          provider: data.provider,
          providerAccountId: data.providerAccountId,
          refresh_token: data.refresh_token,
          access_token: data.access_token,
          expires_at: data.expires_at,
          refresh_expires_in: 180000,
          not_before_policy: data.not_before_policy as number,
          token_type: data.token_type,
          scope: data.scope,
          id_token: data.id_token,
          session_state: data.session_state,
          user: {
            connect: { id: data.userId },
          },
        },
      });
    },
    unlinkAccount: async (provider_providerAccountId) => {
      await prisma.account.delete({
        where: {
          providerAccountId: provider_providerAccountId.providerAccountId,
        },
      });
    },
    async getSessionAndUser(sessionToken) {
      const userAndSession = await prisma.session.findUnique({
        where: { sessionToken },
        include: { user: true },
      });
      if (!userAndSession) return null;
      const { user, ...session } = userAndSession;
      return { user, session };
    },
    createSession: (data) => prisma.session.create({ data }),
    updateSession: (data) =>
      prisma.session.update({
        where: { sessionToken: data.sessionToken },
        data,
      }),
    deleteSession: (sessionToken) =>
      prisma.session.delete({ where: { sessionToken } }),
  };
};

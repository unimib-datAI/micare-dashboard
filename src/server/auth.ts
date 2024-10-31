import { type GetServerSidePropsContext } from 'next';
import {
  type DefaultSession,
  type DefaultUser,
  getServerSession,
  type NextAuthOptions,
  type TokenSet,
} from 'next-auth';
import KeycloakProvider, {
  type KeycloakProfile,
} from 'next-auth/providers/keycloak';

import { env } from '@/env.mjs';
import { prisma } from '@/server/db';
import { type Adapter } from '@/types/adapter';
import { PrismaAdapter } from '@/utils/adapter';
import { Keycloak } from '@/utils/keycloak';

interface Profile extends KeycloakProfile {
  realm_access: { roles: [] };
  phone_number: string | null;
  address: {
    formatted: string;
  };
  group: string[];
}

interface ExtendedAuthOptions extends Omit<NextAuthOptions, 'adapter'> {
  adapter: Adapter;
}

/**
 * Module augmentation for `next-auth` types. Allows us to add custom properties to the `session`
 * object and keep type safety.
 *
 * @see https://next-auth.js.org/getting-started/typescript#module-augmentation
 */
declare module 'next-auth' {
  interface Session extends DefaultSession {
    user: {
      id: string;
      email: string;
      roles: string[];
      group: string[];
      // ...other properties
      // role: UserRole;
    };
    token: {
      access_token: string;
      expires_at: number;
      refresh_token: string;
    };
    error: string;
  }

  interface User extends DefaultUser {
    id: string;
    roles: string[];
    phone?: string | null;
    address?: string | null;
    group: string[];
    // ...other properties
    // role: UserRole;
  }
}

/**
 * Keycloak initialization.
 */
const keycloak = new Keycloak({
  clientId: env.NEXT_PUBLIC_KEYCLOAK_CLIENT_ID,
  host: env.NEXT_PUBLIC_KEYCLOAK_FRONTEND_URL,
  realm: env.NEXT_PUBLIC_KEYCLOAK_REALM,
  clientSecret: env.CLIENT_SECRET,
});

const issuer = `${env.NEXT_PUBLIC_KEYCLOAK_FRONTEND_URL}realms/${env.NEXT_PUBLIC_KEYCLOAK_REALM}`;
console.log('issuer', issuer);
/**
 * Options for NextAuth.js used to configure adapters, providers, callbacks, etc.
 *
 * @see https://next-auth.js.org/configuration/options
 */
export const authOptions: ExtendedAuthOptions = {
  session: {
    strategy: 'jwt',
  },
  pages: {
    signIn: '/auth/sign-in',
    signOut: '/auth/sign-out',
    error: '/auth/error',
  },
  callbacks: {
    jwt: async ({ token, user, account }) => {
      if (user) {
        token.id = user.id;
        token.email = user.email;
        token.roles = user.roles;
        token.group = user.group;
      }

      if (account) {
        token.access_token = account.access_token;
        token.expires_at = account.expires_at;
        token.refresh_token = account.refresh_token;

        return token;
      }

      if (Date.now() < (token.expires_at as number) * 1000) {
        return token;
      }

      try {
        const refreshed_token: TokenSet = await keycloak.refreshToken(
          token.refresh_token as string
        );

        if (!refreshed_token) throw refreshed_token;

        return {
          ...token,
          access_token: refreshed_token.access_token,
          expires_at: Math.floor(
            Date.now() / 1000 + (refreshed_token.expires_in as number)
          ),
          refresh_token: refreshed_token.refresh_token,
        };
      } catch (error) {
        console.error('Error refreshing access token', error);
        // The error property will be used client-side to handle the refresh token error
        return { ...token, error: 'RefreshAccessTokenError' as const };
      }
    },
    session({ session, token }) {
      if (token) {
        session.user.id = token.id as string;
        session.user.email = token.email as string;
        session.user.roles = token.roles as string[];
        session.user.group = token.group as string[];
        session.token = {
          access_token: token.access_token as string,
          expires_at: token.expires_at as number,
          refresh_token: token.refresh_token as string,
        };
        session.error = token.error as string;
        // session.user.role = user.role; <-- put other properties on the session here
      }
      return session;
    },
  },
  adapter: PrismaAdapter(prisma),
  providers: [
    KeycloakProvider<Profile>({
      clientId: env.NEXT_PUBLIC_KEYCLOAK_CLIENT_ID,
      clientSecret: env.CLIENT_SECRET,
      issuer: issuer,
      idToken: true,
      authorization: {
        params: { scope: 'openid phone roles address group' },
        url: `${issuer}/protocol/openid-connect/auth`,
      },
      profile(profile) {
        return {
          id: profile?.sub,
          name: profile?.name,
          email: profile?.email,
          image: profile?.picture,
          roles: profile?.realm_access?.roles,
          phone: profile?.phone_number,
          address: profile?.address?.formatted,
          emailVerified: profile?.email_verified,
          group: profile?.group,
        };
      },
    }),
    /**
     * street
     * locality
     * region
     * postal_code
     * country
     * formatted
     */
    /**
     * ...add more providers here.
     *
     * Most other providers require a bit more work than the Discord provider. For example, the
     * GitHub provider requires you to add the `refresh_token_expires_in` field to the Account
     * model. Refer to the NextAuth.js docs for the provider you want to use. Example:
     *
     * @see https://next-auth.js.org/providers/github
     */
  ],
};

/**
 * Wrapper for `getServerSession` so that you don't need to import the `authOptions` in every file.
 *
 * @see https://next-auth.js.org/configuration/nextjs
 */
export const getServerAuthSession = (ctx: {
  req: GetServerSidePropsContext['req'];
  res: GetServerSidePropsContext['res'];
}) => {
  return getServerSession(ctx.req, ctx.res, authOptions);
};

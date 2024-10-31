import { useRouter } from 'next/router';
import { signIn, signOut, useSession } from 'next-auth/react';
import { useEffect, useState } from 'react';

import { useStorage } from './use-storage';

export function useAuth(shouldRedirect: boolean) {
  const { data: session } = useSession();
  const router = useRouter();
  const [isAuthenticated, setIsAuthenticated] = useState(false);
  const { getItem, setItem } = useStorage();

  useEffect(() => {
    if (session?.error === 'RefreshAccessTokenError') {
      void signOut({ callbackUrl: '/auth/sign-in', redirect: shouldRedirect });
    }

    if (session === null) {
      if (router.route !== '/auth/sign-in') {
        console.log('setting callbackUrl', router.route);
        setItem('callbackUrl', router.route);
        setIsAuthenticated(false);
        console.log('redirecting to /auth/sign-in');
        void router.replace('/auth/sign-in');
      }
      if (router.route === '/auth/sign-in') {
        const callbackUrl = getItem('callbackUrl') ?? '/';
        console.log('callbackUrl in /auth/signin', callbackUrl);
        if (callbackUrl === '/auth/sign-in') {
          void router.replace('/');
        }
        console.log('signing in1');
        void signIn('keycloak', { redirect: true, callbackUrl });
      }
    } else if (session !== undefined) {
      console.log('no-session');
      if (router.route === '/auth/sign-in') {
        const callbackUrl = getItem('callbackUrl') ?? '/';
        console.log('signing in2');
        void signIn('keycloak', { redirect: true, callbackUrl });
      }
      setIsAuthenticated(true);
    }
  }, [session, router, shouldRedirect, getItem, setItem]);

  return isAuthenticated;
}

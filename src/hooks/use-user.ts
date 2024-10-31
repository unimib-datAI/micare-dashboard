import { useRouter } from 'next/router';

import { api } from '@/utils/api';

export const useUser = () => {
  const router = useRouter();
  const {
    data: user,
    isLoading,
    isFetching,
  } = api.therapist.findUnique.useQuery();

  if (!isFetching && !isLoading && !user) {
    console.log('User not found, redirecting to sign-in after sign-out');
    void router.push('/auth/sign-out'); // This should fix inconsistent state after update
  }

  return { user, userInfo: user?.user, isLoading: isLoading || isFetching };
};

/**
 * ${env.NEXT_PUBLIC_KEYCLOAK_FRONTEND_URL}realms/${env.NEXT_PUBLIC_KEYCLOAK_REALM}/protocol/openid-connect/logout?post_logout_redirect_uri=${encodedRedirectUri}
 * %2Fauth%2Fsign-out&client_id=${env.NEXT_PUBLIC_KEYCLOAK_CLIENT_ID}
 */

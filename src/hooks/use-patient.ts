import { useRouter } from 'next/router';

import { api } from '@/utils/api';

export const usePatient = () => {
  const router = useRouter();
  const { username } = router.query;

  const {
    data: patient,
    isLoading,
    isFetching,
  } = api.patient.findUnique.useQuery(
    {
      where: { username: username as string },
    },
    {
      enabled: !!username,
    }
  );

  return { patient, isLoading: isLoading || isFetching };
};

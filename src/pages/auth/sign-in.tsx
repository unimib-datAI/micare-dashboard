import { type NextPage } from 'next';
import { useRouter } from 'next/router';

import { useAuth } from '@/hooks/use-auth';

const SignIn: NextPage = () => {
  const router = useRouter();

  const isAuthenticated = useAuth(true);
  console.log({ isAuthenticated });

  const { error } = router.query;

  if (error) {
    console.log({ error });
    return;
  }

  return error ? <p>Errore</p> : <main />;
};

export default SignIn;

SignIn.getLayout = (page) => <>{page}</>;

export const getServerSideProps = () => {
  return {
    props: {},
  };
};

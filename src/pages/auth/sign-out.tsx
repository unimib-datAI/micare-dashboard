import { type NextPage } from 'next';
import { signOut } from 'next-auth/react';

const SignOut: NextPage = () => {
  void signOut({ callbackUrl: '/', redirect: true });

  return <main />;
};

export default SignOut;

SignOut.getLayout = (page) => <>{page}</>;

export const getServerSideProps = () => {
  return {
    props: {},
  };
};

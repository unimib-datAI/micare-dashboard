import '@/styles/globals.css';

import { type AppProps } from 'next/app';
import Head from 'next/head';
import { useRouter } from 'next/router';
import { SessionProvider } from 'next-auth/react';

import { NextFonts } from '@/components/next-fonts';
import { Toaster } from '@/components/ui/toaster';
import { _default as Layout } from '@/layout';
import { api } from '@/utils/api';
import { makeTitle } from '@/utils/make-title';

const MyApp = ({
  Component,
  pageProps: { session, ...pageProps },
}: AppProps) => {
  const getLayout = Component.getLayout ?? ((page) => <Layout>{page}</Layout>);
  const router = useRouter();
  const { title } = makeTitle(router.asPath);

  return (
    <>
      <Head>
        <link rel="icon" href="/favicon.ico" />
        <title>{title}</title>
      </Head>
      <SessionProvider session={session} refetchInterval={5 * 60}>
        <NextFonts />
        {getLayout(<Component {...pageProps} />)}
        <Toaster />
      </SessionProvider>
    </>
  );
};

export default api.withTRPC(MyApp);

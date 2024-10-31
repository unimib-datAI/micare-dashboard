import type { NextComponentType, NextPageContext } from 'next';
import type { AppInitialProps } from 'next/app';
import { type Session } from 'next-auth';

// export declare type NextPageWithLayout<P = object, IP = P> = NextPage<P, IP> & {
//   /**
//    * If a page uses a layout, define it here wrapping the page with the layout
//    * @example
//    * ```tsx
//    * // pages/index.tsx
//    * import { type NextPageWithLayout } from "@/types/NextPageWithLayout";
//    * import { MyLayout as Layout } from 'layouts'
//    *
//    * const Page: NextPageWithLayout = () => <p>Hello world</p>
//    *
//    * Page.getLayout = (page) => <Layout>{page}</Layout>
//    *
//    * export default Page
//    *
//    * ```
//    */
//   getLayout?: (page: ReactElement) => ReactNode;
// };

declare module 'next' {
  export type NextPage<
    Props = object,
    InitialProps = Props
  > = NextComponentType<NextPageContext, InitialProps, Props> & {
    /**
     * If a page uses a layout, define it here wrapping the page with the layout
     * @example
     * ```tsx
     * // pages/index.tsx
     * import { type NextPageWithLayout } from "@/types/NextPageWithLayout";
     * import { MyLayout as Layout } from 'layouts'
     *
     * const Page: NextPageWithLayout = () => <p>Hello world</p>
     *
     * Page.getLayout = (page) => <Layout>{page}</Layout>
     *
     * export default Page
     *
     * ```
     */
    getLayout?: (page: ReactElement) => ReactNode;
  };
}

declare module 'next/app' {
  export declare type AppProps<P = unknown> = AppInitialProps<P> & {
    Component: NextComponentType<NextPageContext, unknown, unknown> & {
      /**
       * If a page uses a layout, define it here wrapping the page with the layout
       * @example
       * ```tsx
       * // pages/index.tsx
       * import { type NextPageWithLayout } from "@/types/NextPageWithLayout";
       * import { MyLayout as Layout } from 'layouts'
       *
       * const Page: NextPageWithLayout = () => <p>Hello world</p>
       *
       * Page.getLayout = (page) => <Layout>{page}</Layout>
       *
       * export default Page
       *
       * ```
       */
      getLayout?: (page: ReactElement) => ReactNode;
    };
    router: Router;
    __N_SSG?: boolean | undefined;
    __N_SSP?: boolean | undefined;
    pageProps: P & {
      /** Initial session passed in from `getServerSideProps` or `getInitialProps` */
      session?: Session | null;
    };
  };
}

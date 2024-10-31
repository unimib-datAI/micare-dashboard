import Link, { type LinkProps } from 'next/link';
import { useRouter } from 'next/router';
import React, { type PropsWithChildren } from 'react';

type ExtendedLinkProps = LinkProps & {
  routeToAppend?: string;
  className?: string;
};

const ExtendedLink = ({
  children,
  routeToAppend,
  ...props
}: PropsWithChildren<ExtendedLinkProps>) => {
  const router = useRouter();

  return (
    <Link {...props} href={`${router.asPath}/${routeToAppend ?? ''}`}>
      {children}
    </Link>
  );
};

export default ExtendedLink;

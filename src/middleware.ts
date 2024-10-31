import { NextResponse } from 'next/server';
import { withAuth } from 'next-auth/middleware';

import { env } from '@/env.mjs';

export default withAuth(function middleware(req) {
  if (req.nextauth?.token?.error === 'RefreshAccessTokenError') {
    return NextResponse.redirect(`${env.NEXT_PUBLIC_AUTH_URL}/auth/sign-out`);
  }
});

export const config = { matcher: ['/', '/((?!api|auth).*)'] };

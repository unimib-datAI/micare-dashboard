import { PrismaClient } from '@prisma/client';
// eslint-disable-next-line @typescript-eslint/no-unused-vars
import { cookies, headers } from 'next/headers';

import { env } from '@/env.mjs';

const globalForPrisma = globalThis as unknown as { prisma: PrismaClient };

export const prisma =
  globalForPrisma.prisma ||
  new PrismaClient({
    log:
      env.NEXT_PUBLIC_TRPC_LOGGER_ENABLED === 'true'
        ? ['query', 'error', 'warn']
        : ['error'],
  });

if (env.NODE_ENV !== 'production') globalForPrisma.prisma = prisma;

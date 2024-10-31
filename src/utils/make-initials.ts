import { type Prisma } from '@prisma/client';

export const makeInitials = (
  name: Prisma.UserCreateWithoutSessionInput['name']
) => {
  if (!name) return '';

  const [first, last] = name.split(' ');

  if (!first || !last) return '';
  if (!first[0] || !last[0]) return '';

  return `${first[0]}${last[0]}`;
};

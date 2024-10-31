import { Cog, LogOut, User } from 'lucide-react';
import Image from 'next/image';
import Link from 'next/link';

import { Avatar, AvatarFallback, AvatarImage } from '@/components/ui/avatar';
import { Button } from '@/components/ui/button';
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from '@/components/ui/popover';
import { Shimmer } from '@/components/ui/schimmer';
import { env } from '@/env.mjs';
import { useUser } from '@/hooks/use-user';
import { makeInitials } from '@/utils/make-initials';

import { Separator } from './separator';

const encodedRedirectUri = encodeURIComponent(env.NEXT_PUBLIC_AUTH_URL);
const logoutUri = `${env.NEXT_PUBLIC_KEYCLOAK_FRONTEND_URL}realms/${env.NEXT_PUBLIC_KEYCLOAK_REALM}/protocol/openid-connect/logout?post_logout_redirect_uri=${encodedRedirectUri}%2Fauth%2Fsign-out&client_id=${env.NEXT_PUBLIC_KEYCLOAK_CLIENT_ID}`;
const ITEMS = [
  { name: 'Profilo', href: '/profile', icon: User, separator: false },
  { name: 'Impostazioni', href: '/settings', icon: Cog, separator: false },
  {
    name: 'Disconnettiti',
    href: logoutUri,
    icon: LogOut,
    separator: true,
  },
] as const;

const Header = () => {
  const { userInfo, isLoading } = useUser();

  const avatarInfo = {
    initials: makeInitials(userInfo?.name),
    image: userInfo?.image ?? '#',
  };

  return (
    <header className="fixed top-0 z-50 w-full bg-forest-green-700">
      <div className="flex items-center gap-4 p-4 px-3 py-3 lg:px-5 lg:pl-3">
        <Link href="/" className="flex items-center gap-2 px-4">
          <Image
            className="h-30 w-30"
            width={70}
            height={70}
            src="/images/logo.svg"
            alt="PsitTools logo"
          />
          <span className="text-2xl pl-4 font-bold text-white">PsitTools</span>
        </Link>
        <Popover>
          <PopoverTrigger className="ml-auto flex items-center gap-4 text-white">
            <p>{userInfo?.name}</p>
            <Avatar>
              {isLoading ? (
                <Shimmer className="h-full w-full" />
              ) : (
                <>
                  <AvatarImage src={avatarInfo.image} placeholder="blur" />
                  <AvatarFallback className="bg-white/20 text-white">
                    {avatarInfo.initials}
                  </AvatarFallback>
                </>
              )}
            </Avatar>
          </PopoverTrigger>
          <PopoverContent
            className="w-auto bg-white"
            align="end"
            sideOffset={8}
          >
            <ul className="flex flex-col gap-2">
              {ITEMS.map(({ name, href, icon: Icon, separator }) => (
                <li key={name}>
                  {separator && (
                    <Separator
                      className="my-2 bg-forest-green-700/20"
                      aria-hidden
                    />
                  )}

                  <Button
                    as={Link}
                    href={href}
                    className="w-full justify-end"
                    variant="ghost"
                    size="sm"
                    type="button"
                    isDisabled={name !== 'Disconnettiti'} //TODO: remove this when profile and settings pages are implemented
                  >
                    <span className="mr-3 whitespace-nowrap">{name}</span>

                    <Icon className="sidebar-icon" />
                  </Button>
                </li>
              ))}
            </ul>
          </PopoverContent>
        </Popover>
      </div>
    </header>
  );
};

export default Header;

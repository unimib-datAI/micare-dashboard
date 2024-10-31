import { ArrowBigLeft, Settings, UserCog } from 'lucide-react';
import Link from 'next/link';
import { useRouter } from 'next/router';

import { Avatar, AvatarFallback, AvatarImage } from '@/components/ui/avatar';
import { Button } from '@/components/ui/button';
import { Label } from '@/components/ui/label';
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from '@/components/ui/popover';
import { Shimmer } from '@/components/ui/schimmer';
import { Separator } from '@/components/ui/separator';
import { Switch } from '@/components/ui/switch';
import { api } from '@/utils/api';
import { makeInitials } from '@/utils/make-initials';

const FOLDERS = [
  { name: 'Cartella clinica', href: '/medical-records' },
  { name: 'Annotazioni', href: '/notes' },
  { name: 'Materiale', href: '/drive' },
  { name: 'Somministrazioni', href: '/administrations' },
  { name: 'Diari', href: '/diaries' },
];

export const Header = () => {
  const { pathname, query, back } = useRouter();
  const activeState = (href: string) => {
    return pathname.includes(href) ? 'active' : 'inactive';
  };

  const { data: user, isLoading } = api.user.findUnique.useQuery(
    {
      where: {
        username: query.username as string,
      },
    },
    {
      enabled: !!query.username,
    }
  );

  const { data: onGoing } = api.medicalRecord.findUnique.useQuery(
    {
      where: {
        patientId: user?.id,
      },
    },
    {
      select: (data) => data?.ongoing,
      enabled: !!user,
    }
  );

  const utils = api.useContext();
  const updateMedicalRecord = api.medicalRecord.update.useMutation({
    onSuccess: async () => {
      await utils.medicalRecord.invalidate();
      await utils.therapist.invalidate();
    },
  });

  const switchState = () => {
    if (!user) return;
    updateMedicalRecord.mutate({
      where: {
        patientId: user?.id,
      },
      data: {
        ongoing: !onGoing,
      },
    });
  };

  return (
    <header className="sticky top-[4rem] z-10 -m-3 flex h-auto justify-between bg-gray-10 p-3">
      <div className="flex gap-2 bg-gray-10">
        <Button variant="ghost" size="icon" onClick={() => back()}>
          <ArrowBigLeft className="h-6 w-6 fill-forest-green-700 text-forest-green-700" />
        </Button>
        {!user || isLoading ? (
          <div className="grid grid-cols-[2.5rem_1fr] grid-rows-2 items-center gap-x-2 gap-y-1 whitespace-nowrap font-medium leading-none text-gray-900 dark:text-white">
            <Shimmer
              height={40}
              width={40}
              className="row-span-2 rounded-full"
            />
            <Shimmer height={16} width={160} className="self-end rounded-md" />
            <Shimmer
              height={16}
              width={160}
              className="self-start rounded-md"
            />
          </div>
        ) : (
          <div className="grid grid-cols-[2.5rem_1fr] grid-rows-2 items-center gap-x-2 gap-y-1 whitespace-nowrap font-medium leading-none text-gray-900 dark:text-white">
            <Avatar className="row-span-2">
              <>
                <AvatarImage src={user?.image ?? ''} placeholder="blur" />
                <AvatarFallback className="bg-forest-green-200 text-white">
                  {makeInitials(user?.name)}
                </AvatarFallback>
              </>
            </Avatar>
            <p className="self-end font-bold">{user?.name}</p>
            <p className="self-start font-light">{user?.email}</p>
          </div>
        )}
      </div>
      <div className="flex gap-2 pr-2">
        <nav>
          <ul className="inline-flex h-10 items-center justify-center rounded-md bg-muted p-1 text-muted-foreground">
            {FOLDERS.map((folder) => {
              const { name, href } = folder;
              const { username } = query;

              return (
                <Link
                  href={`/patients/${username as string}${href}`}
                  key={name}
                  replace
                >
                  <li
                    data-state={activeState(href)}
                    className="inline-flex items-center justify-center whitespace-nowrap rounded-sm px-3 py-1.5 text-base font-medium ring-offset-background transition-all focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50 data-[state=active]:bg-background data-[state=active]:text-foreground data-[state=active]:shadow-sm"
                  >
                    {name}
                  </li>
                </Link>
              );
            })}
          </ul>
        </nav>
        <Popover>
          <PopoverTrigger>
            <Settings className="h-10 w-10 rounded-full p-2 text-forest-green-700 hover:bg-forest-green-700/10" />
          </PopoverTrigger>
          <PopoverContent
            className="w-auto space-y-2 bg-white"
            align="end"
            sideOffset={8}
          >
            <Button variant="ghost" icon="left">
              <UserCog className="mr-2" />
              <span className="text-gray-900 dark:text-white">
                Profilo paziente
              </span>
            </Button>
            <Separator />
            <div>
              <span className="-mb-2 text-sm">
                {onGoing ? 'Archivia paziente' : 'Ripristina paziente'}
              </span>
              <Label
                htmlFor="airplane-mode"
                className="flex cursor-pointer items-center rounded-md px-2 py-2.5 hover:bg-forest-green-700/10"
              >
                <Switch
                  id="airplane-mode"
                  checked={!onGoing}
                  onCheckedChange={switchState}
                  className="mr-2 data-[state=checked]:bg-red-400 data-[state=unchecked]:bg-emerald-400"
                />
                {onGoing ? 'In Corso' : 'Archiviato'}
              </Label>
            </div>
          </PopoverContent>
        </Popover>
      </div>
    </header>
  );
};

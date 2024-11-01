import { CalendarDays, ClipboardList, Clock } from 'lucide-react';
import Link from 'next/link';
import { useRouter } from 'next/router';
import React from 'react';

import { Button } from '@/components/ui/button';
import {
  Card,
  CardContent,
  CardFooter,
  CardHeader,
  CardTitle,
} from '@/components/ui/card';

interface AdministrationCardDetailProps
  extends React.HTMLAttributes<HTMLDivElement> {
  testType: string;
  testNumber: string;
  date: string;
}

export const AdministrationCardDetail = (
  props: AdministrationCardDetailProps
) => {
  const { testType, testNumber, date } = props;
  const { asPath } = useRouter();
  const id = asPath.split('/').pop() ?? '';

  const basePath = asPath.split('/').slice(0, -2).join('/');

  console.log({ basePath, id });

  return (
    <div className="w-72">
      <Card className="flex flex-col gap-4">
        <CardHeader className="pb-0">
          <CardTitle className="font-h2">Somministrazione</CardTitle>
        </CardHeader>
        <CardContent className="pb-0">
          <div className="grid grid-cols-[auto,_1fr] grid-rows-3 items-center gap-x-2 gap-y-2">
            <ClipboardList className="text-slate-400" size={18} />
            <span>{testType}</span>

            <Clock className="text-slate-400" size={18} />
            <span>{testNumber}</span>

            <CalendarDays className="text-slate-400" size={18} />
            <span>{date}</span>
          </div>
        </CardContent>
        <CardFooter className="flex justify-end">
          <Button as={Link} className="w-full" href={`${basePath}/view/${id}`}>
            Vedi test
          </Button>
        </CardFooter>
      </Card>
    </div>
  );
};

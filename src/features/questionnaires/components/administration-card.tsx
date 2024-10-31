import Link from 'next/link';
import { useRouter } from 'next/router';

import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from '@/components/ui/card';
import { available } from '@/features/questionnaires/settings';
import { cn } from '@/utils/cn';

const isActive = (type: (typeof available)[number]) => {
  return available.includes(type);
};

type Props = {
  administrationType: string;
  numOfAdministrations: number;
  lastAdministration: string;
  administrationId: (typeof available)[number];
};

export const AdministrationCard = (props: Props) => {
  const {
    administrationType,
    numOfAdministrations,
    lastAdministration,
    administrationId,
  } = props;

  const router = useRouter();
  const pathname = router.asPath;

  return (
    <div className="w-72 p-3">
      <Card
        key={administrationType}
        className={cn(
          'relative flex h-full w-full flex-col transition-all duration-300',
          !isActive(administrationId) && 'pointer-events-none opacity-50'
        )}
      >
        <CardHeader className="space-y-0 pb-0">
          <CardTitle className="font-h2 line-clamp-1 break-all pr-1 text-base">
            {administrationType}
          </CardTitle>
          <CardDescription className="pb-4 leading-4">
            Ultima somministrazione:
            <br />
            <span className="text-forest-green-700">{lastAdministration}</span>
          </CardDescription>
          <Badge className="absolute right-6 top-6 h-8 w-8 items-center justify-center bg-forest-green-300 text-white">
            <span className="font-normal">{numOfAdministrations}</span>
          </Badge>
        </CardHeader>
        <CardContent className="flex flex-col gap-2">
          <Button
            as={Link}
            href={`${pathname}/new/${administrationId}`}
            variant={'outline'}
            size={'sm'}
            className="w-full"
          >
            Nuova compilazione
          </Button>

          <Button
            as={Link}
            href={`${pathname}/results/${administrationId}`}
            size={'sm'}
            className="w-full"
            isDisabled={numOfAdministrations === 0}
          >
            Vai ai risultati
          </Button>
        </CardContent>
      </Card>
    </div>
  );
};

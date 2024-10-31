import { type Note as TNote } from '@prisma/client';
import { format } from 'date-fns';
import { it } from 'date-fns/locale';
import { Edit, Expand } from 'lucide-react';

import { Button } from '@/components/ui/button';
import {
  Card,
  CardContent,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle,
} from '@/components/ui/card';
import { Separator } from '@/components/ui/separator';
import { PinSelector } from '@/features/notes/components/pin-selector';
import { api } from '@/utils/api';
import { cn } from '@/utils/cn';

import { Dialog } from './open-note-dialog';
import { ReadNote } from './read-note';

type Props = {
  note: TNote;
  containerRef: React.RefObject<HTMLDivElement>;
  className?: string;
};

export const NoteCard = (props: Props) => {
  const { data: therapist, isLoading } = api.therapist.findUnique.useQuery();
  if (isLoading) return null;

  const { note, containerRef, className } = props;
  const { id, title, content, date, pinned } = note;
  return (
    <div className={cn('p-3', className)}>
      <Card
        key={id}
        className={cn(
          'relative flex h-full w-full flex-col transition-all duration-300',
          pinned && 'shadow-forest-green-700/50'
        )}
      >
        <CardHeader className="space-y-0 pb-4">
          <CardTitle className="font-h2 line-clamp-1 break-all pr-1 text-base">
            {title}
          </CardTitle>
          <CardDescription className="pb-4">
            Creata da{' '}
            <span className="text-forest-green-700">
              {therapist?.user?.name}
            </span>{' '}
            il{' '}
            <span className="text-forest-green-700">
              {format(date, 'P', { locale: it })}
            </span>
          </CardDescription>
          <Separator className="h-[1px] bg-forest-green-700/20" />
        </CardHeader>
        <CardContent className="pb-2">
          <p className="line-clamp-3 text-sm">{content}</p>
        </CardContent>
        <CardFooter className="mt-auto flex pb-2">
          <PinSelector note={note} />
          <Dialog
            containerRef={containerRef}
            trigger={
              <Button
                variant="ghost"
                className="ml-auto text-sm text-forest-green-700"
              >
                <Edit className="mr-1 h-4 w-4" /> Modifica
              </Button>
            }
            note={note}
          />
          <ReadNote
            containerRef={containerRef}
            trigger={
              <Button
                variant="ghost"
                className="-mr-4 text-sm text-forest-green-700"
              >
                <Expand className="mr-1 h-4 w-4" />
                Apri
              </Button>
            }
            createdBy={therapist?.user?.name}
            note={note}
          />
        </CardFooter>
      </Card>
    </div>
  );
};

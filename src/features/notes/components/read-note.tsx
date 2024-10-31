import { type Note as TNote } from '@prisma/client';
import { format } from 'date-fns';
import { it } from 'date-fns/locale';
import { X } from 'lucide-react';
import { useEffect, useState } from 'react';

import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from '@/components/ui/dialog';
import { ScrollArea } from '@/components/ui/scroll-area';

type Props = {
  note: TNote;
  containerRef: React.RefObject<HTMLDivElement>;
  trigger: React.ReactNode;
  createdBy: string | null | undefined;
};

export const ReadNote = (props: Props) => {
  const { note, containerRef, trigger, createdBy } = props;
  const { title, date, content } = note;
  const [open, setOpen] = useState(false);

  useEffect(() => {
    if (!open) {
      return document.body.classList.remove('overflow-hidden');
    } else {
      document.body.classList.add('overflow-hidden');
    }
  }, [open]);

  return (
    <Dialog open={open} onOpenChange={setOpen} modal={false}>
      <DialogTrigger asChild>{trigger}</DialogTrigger>
      <DialogContent
        onInteractOutside={(e) => e.preventDefault()}
        portalProps={{
          container: containerRef.current,
          className: 'absolute m-3 h-full overflow-auto',
        }}
        overlayProps={{
          className: 'absolute',
        }}
        closeComponent={<X className="h-6 w-6 text-red-800" />}
        className="absolute inset-0"
      >
        <ScrollArea type="always">
          <div className="mx-auto flex max-w-prose flex-col gap-4">
            <DialogHeader>
              <DialogTitle>{title}</DialogTitle>
              <DialogDescription>
                Creata da{' '}
                <span className="text-forest-green-700">
                  {createdBy ?? 'Anonimo'}
                </span>{' '}
                il{' '}
                <span className="text-forest-green-700">
                  {format(date, 'P', { locale: it })}
                </span>
              </DialogDescription>
            </DialogHeader>
            <p className="font-default">{content}</p>
            <p>{content}</p>
          </div>
        </ScrollArea>
      </DialogContent>
    </Dialog>
  );
};

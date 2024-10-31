import { X } from 'lucide-react';
import { useEffect, useState } from 'react';

import {
  Dialog as DialogComponent,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from '@/components/ui/dialog';

import { Form } from './add-note-form';

type Props = {
  containerRef: React.RefObject<HTMLDivElement>;
  trigger: React.ReactNode;
};

export const Dialog = (props: Props) => {
  const { containerRef, trigger } = props;
  const [open, setOpen] = useState(false);

  useEffect(() => {
    if (open) {
      document.body.classList.add('overflow-hidden');
    } else {
      document.body.classList.remove('overflow-hidden');
    }
  }, [open]);

  return (
    <DialogComponent open={open} onOpenChange={setOpen} modal={false}>
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
        className="absolute inset-0 grid-rows-[auto,1fr]"
      >
        <DialogHeader>
          <DialogTitle>Creazione nota</DialogTitle>
        </DialogHeader>
        <Form className="overflow-y-auto" close={() => setOpen(false)} />
      </DialogContent>
    </DialogComponent>
  );
};

import { zodResolver } from '@hookform/resolvers/zod';
import { type Note as TNote } from '@prisma/client';
import { AnimatePresence, motion } from 'framer-motion';
import { Loader2 as LoaderIcon, Save as SaveIcon, Star } from 'lucide-react';
import { type DetailedHTMLProps, type FormHTMLAttributes } from 'react';
import {
  Controller,
  type SubmitErrorHandler,
  type SubmitHandler,
  useForm,
} from 'react-hook-form';

import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle,
  AlertDialogTrigger,
} from '@/components/ui/alert-dialog';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Toggle } from '@/components/ui/toggle';
import { useToast } from '@/hooks/use-toast';
import {
  type CreateNoteSchema,
  createNoteSchema,
} from '@/types/zod/schema/create-note.schema';
import { api } from '@/utils/api';

type Props = DetailedHTMLProps<
  FormHTMLAttributes<HTMLFormElement>,
  HTMLFormElement
> & {
  close: () => void;
  note: TNote;
  containerRef: React.RefObject<HTMLDivElement>;
};

const Loader2 = motion(LoaderIcon);
const Save = motion(SaveIcon);

export const Form = (props: Props) => {
  const { close, note, ...rest } = props;

  const { handleSubmit, formState, register, control } =
    useForm<CreateNoteSchema>({
      mode: 'onChange',
      reValidateMode: 'onChange',
      shouldUnregister: true,
      resolver: zodResolver(createNoteSchema),
      defaultValues: note,
    });

  const utils = api.useContext();
  const updateNote = api.note.update.useMutation({
    onSuccess: async () => {
      console.log('success');
      toast({
        title: 'Successo',
        description: 'La nota è stata aggiornata',
      });

      await utils.note.invalidate();
      return close();
    },
    onError: (_error) => {
      return toast({
        title: 'Errore',
        description:
          "Si è verificato un errore durante l'aggiornamento della nota, riprova più tardi",
        variant: 'destructive',
      });
    },
  });
  const deleteNote = api.note.delete.useMutation({
    onSuccess: async () => {
      console.log('success');
      toast({
        title: 'Successo',
        description: 'La nota è stata eliminata',
      });

      await utils.note.invalidate();
      return close();
    },
    onError: (_error) => {
      return toast({
        title: 'Errore',
        description:
          "Si è verificato un errore durante l'eliminazione della nota, riprova più tardi",
        variant: 'destructive',
      });
    },
  });
  const { toast } = useToast();

  const onError: SubmitErrorHandler<CreateNoteSchema> = (_error) => {
    console.log(_error);
    toast({
      title: 'Attenzione',
      description:
        'Alcuni campi non sono validi, correggi gli errori e riprova',
      variant: 'warning',
    });
  };

  const onSubmit: SubmitHandler<CreateNoteSchema> = async (data) => {
    const { title, content, pinned } = data;
    const date = new Date();

    const response = await updateNote.mutateAsync({
      where: { id: note.id },
      data: {
        title: title.trim(),
        content: content.trim(),
        pinned,
        date,
      },
    });

    console.log(response);
  };

  return (
    <form
      onSubmit={handleSubmit(onSubmit, onError)}
      {...rest}
      className="mx-auto flex min-h-full w-full max-w-prose flex-col"
    >
      <div className="flex flex-col gap-4">
        <Input
          {...register('title')}
          label="Titolo"
          type="text"
          labelClassName="text-forest-green-700"
          placeholder="Titolo"
        />
        <Input
          {...register('content')}
          label="Contenuto"
          labelClassName="text-forest-green-700"
          type="textArea"
          rows={10}
          placeholder="Contenuto"
        />
        <Controller
          name="pinned"
          control={control}
          render={({ field }) => {
            return (
              <Toggle
                aria-label="Mostra solo note in evidenza"
                size="lg"
                pressed={field.value}
                onPressedChange={field.onChange}
                variant="outline"
                className="mr-auto justify-start text-base text-slate-500 [&>svg]:data-[state=on]:fill-amber-300 [&>svg]:data-[state=on]:stroke-amber-300"
              >
                <span className="mr-2">In evidenza</span>
                <Star className="h-5 w-5" />
              </Toggle>
            );
          }}
        />
      </div>
      <div className="mx-auto mt-auto flex w-full justify-end">
        <AlertDialog>
          <AlertDialogTrigger asChild>
            <Button variant="ghost" className="text-red-500">
              Elimina
            </Button>
          </AlertDialogTrigger>
          <AlertDialogContent
            portalProps={{
              container: props.containerRef.current,
              className: 'absolute mt-3 h-screen-safe',
            }}
            overlayProps={{
              className: 'absolute',
            }}
          >
            <AlertDialogHeader>
              <AlertDialogTitle>Sei assolutamente sicuro/a?</AlertDialogTitle>
              <AlertDialogDescription>
                Questa azione non può essere annullata. Premendo
                &quote;Elimina&quote; la nota sarà eliminata in modo permanente.
              </AlertDialogDescription>
            </AlertDialogHeader>
            <AlertDialogFooter>
              <AlertDialogCancel>Annulla</AlertDialogCancel>
              <AlertDialogAction
                onClick={() => deleteNote.mutate({ where: { id: note.id } })}
              >
                Elimina
              </AlertDialogAction>
            </AlertDialogFooter>
          </AlertDialogContent>
        </AlertDialog>
        <Button
          type="submit"
          icon="right"
          className="ml-3"
          disabled={formState.isSubmitting}
        >
          Aggiorna
          <AnimatePresence mode="wait">
            {formState.isSubmitting ? (
              <Loader2 className="mr-2 animate-spin" />
            ) : (
              <Save className="ml-2" />
            )}
          </AnimatePresence>
        </Button>
      </div>
    </form>
  );
};

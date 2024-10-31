import { zodResolver } from '@hookform/resolvers/zod';
import { AnimatePresence, motion } from 'framer-motion';
import { Loader2 as LoaderIcon, Save as SaveIcon, Star } from 'lucide-react';
import { type DetailedHTMLProps, type FormHTMLAttributes } from 'react';
import {
  Controller,
  type SubmitErrorHandler,
  type SubmitHandler,
  useForm,
} from 'react-hook-form';

import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Toggle } from '@/components/ui/toggle';
import { usePatient } from '@/hooks/use-patient';
import { useToast } from '@/hooks/use-toast';
import { useUser } from '@/hooks/use-user';
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
};

const Loader2 = motion(LoaderIcon);
const Save = motion(SaveIcon);

export const Form = (props: Props) => {
  const { close, ...rest } = props;

  const { user } = useUser();
  const { patient } = usePatient();

  const { handleSubmit, formState, register, control } =
    useForm<CreateNoteSchema>({
      mode: 'onChange',
      reValidateMode: 'onChange',
      shouldUnregister: true,
      resolver: zodResolver(createNoteSchema),
    });

  const utils = api.useContext();
  const createNote = api.note.create.useMutation({
    onSuccess: async () => {
      console.log('success');
      toast({
        title: 'Successo',
        description: 'La nota è stata creata',
      });

      await utils.note.invalidate();
      return close();
    },
    onError: (_error) => {
      return toast({
        title: 'Errore',
        description:
          'Si è verificato un errore durante la creazione della nota, riprova più tardi',
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
    const patientId = patient?.id;
    const therapistId = user?.id;

    const response = await createNote.mutateAsync({
      data: {
        title,
        content,
        pinned,
        date,
        patient: {
          connect: {
            id: patientId,
          },
        },
        therapist: {
          connect: {
            id: therapistId,
          },
        },
      },
    });

    console.log(response);
  };

  return (
    <form
      onSubmit={handleSubmit(onSubmit, onError)}
      {...rest}
      className="mx-auto flex w-full max-w-prose flex-col"
    >
      <div className="flex flex-col gap-4">
        <Input
          {...register('title')}
          label="Titolo"
          labelClassName="text-forest-green-700"
          type="text"
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
          defaultValue={false}
          control={control}
          render={({ field }) => {
            return (
              <Toggle
                aria-label="Mostra solo note in evidenza"
                size="lg"
                pressed={field.value}
                onPressedChange={field.onChange}
                variant="outline"
                className="mr-auto justify-start text-base text-slate-500 transition-all duration-300 [&>svg]:data-[state=on]:fill-amber-300 [&>svg]:data-[state=on]:stroke-amber-300"
              >
                <span className="mr-2">In evidenza</span>
                <Star className="h-5 w-5" />
              </Toggle>
            );
          }}
        />
      </div>
      <div className="mx-auto mt-auto flex w-full justify-between">
        <Button
          type="submit"
          icon="right"
          className="ml-auto"
          disabled={formState.isSubmitting}
        >
          <span className="mr-2">Salva</span>
          <AnimatePresence mode="wait">
            {formState.isSubmitting ? (
              <Loader2 className="h-5 w-5 animate-spin" />
            ) : (
              <Save className="h-5 w-5" />
            )}
          </AnimatePresence>
        </Button>
      </div>
    </form>
  );
};

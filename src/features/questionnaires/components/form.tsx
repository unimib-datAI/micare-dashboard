import { AnimatePresence, motion } from 'framer-motion';
import {
  CircleHelp,
  Loader2 as LoaderIcon,
  Send as SendIcon,
  Verified,
} from 'lucide-react';
import { useRouter } from 'next/router';
import { useContext } from 'react';
import {
  type FieldValues,
  type SubmitErrorHandler,
  type SubmitHandler,
  type UseFormReturn,
} from 'react-hook-form';
import { type ClassNameValue } from 'tailwind-merge';

import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogContent,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle,
} from '@/components/ui/alert-dialog';
import { Button } from '@/components/ui/button';
import { Dialog, DialogContent, DialogTrigger } from '@/components/ui/dialog';
import { Form } from '@/components/ui/form';
import { RootContainerRefContext } from '@/context';
import { useAdministrationContext } from '@/features/questionnaires/context/administration';
import { type available } from '@/features/questionnaires/settings';
import { useToast } from '@/hooks/use-toast';
import { cn } from '@/utils/cn';

type FormTitleProps = {
  title: string;
};

export const FormTitle = (props: FormTitleProps) => {
  const { title } = props;
  return (
    <header className="sticky top-32 mx-auto max-w-prose pb-3">
      <h1 className="font-h1 leading-tight">{title}</h1>
    </header>
  );
};

type FormContentProps<FormValues extends FieldValues> = {
  children: React.ReactNode;
  form: UseFormReturn<FormValues>;
  title: string;
};

export const FormContent = <FormValues extends FieldValues>(
  props: FormContentProps<FormValues>
) => {
  const { children, form, title } = props;
  return (
    <div className="grid h-[calc(100dvh_-_theme(spacing.6)_-_theme(spacing.32))] grid-rows-[auto_1fr_auto]">
      <Form {...form}>
        <FormTitle title={title} />
        <div className="overflow-y-auto pb-8">
          <form className="mx-auto max-w-prose space-y-6">
            <section className="pb-4">{children}</section>
          </form>
        </div>
      </Form>
    </div>
  );
};

type FormHeaderProps = {
  children: React.ReactNode;
};

export const FormHeader = (props: FormHeaderProps) => {
  return (
    <header className="sticky top-0 z-10 w-full space-y-4 bg-gray-10 pb-4">
      {props.children}
    </header>
  );
};

type FormInstructionsProps = {
  children: React.ReactNode;
};

export const FormInstructions = (props: FormInstructionsProps) => {
  const { children } = props;
  return (
    <Dialog>
      <DialogTrigger className="w-full rounded-md bg-white p-4">
        <p className="flex items-center justify-between font-bold">
          Istruzioni{' '}
          <CircleHelp className="ml-2 h-5 w-5 text-forest-green-700" />
        </p>
      </DialogTrigger>
      <DialogContent className="max-w-prose rounded-md p-8">
        {children}
      </DialogContent>
    </Dialog>
  );
};

type FormFooterProps = {
  type: (typeof available)[number];
  children: React.ReactNode;
  className?: ClassNameValue;
};

export const FormFooter = (props: FormFooterProps) => {
  const { type, children, className } = props;

  const { back, replace, query } = useRouter();
  const { username } = query as { username: string };

  const containerRef = useContext(RootContainerRefContext);
  const { id, sent, dispatch } = useAdministrationContext();

  const navigateToResults = async () => {
    if (!username) return;
    try {
      await replace(
        `/patients/${username}/administrations/results/${type}/administration/${id}`
      );
    } catch (error) {
      console.error(error);
    }
  };

  const setSent = (open: boolean) => {
    dispatch({ type: 'set_sent', payload: { sent: open } });
  };

  return (
    <>
      <footer className="absolute bottom-0 left-0 right-0 flex justify-center bg-gray-10 p-3">
        <div className={cn('flex w-full max-w-prose', className)}>
          {children}
        </div>
      </footer>
      <div className="mx-auto mt-auto flex w-full justify-end">
        <AlertDialog open={sent} onOpenChange={setSent}>
          <AlertDialogContent
            portalProps={{
              container: containerRef.current,
              className: 'absolute mt-3 h-screen-safe',
            }}
            overlayProps={{
              className: 'absolute',
            }}
          >
            <AlertDialogHeader>
              <AlertDialogTitle className="flex items-center">
                <Verified className="mr-1.5 h-20 w-20 text-forest-green-700" />
                Il questionario è stato caricato con successo!
              </AlertDialogTitle>
            </AlertDialogHeader>
            <AlertDialogFooter className="flex flex-col">
              <AlertDialogAction
                variant="ghost"
                className="text-forest-green-700"
                onClick={() => back()}
              >
                Torna alla pagina delle somministrazioni
              </AlertDialogAction>
              <AlertDialogAction onClick={() => navigateToResults()}>
                Vai al risultato
              </AlertDialogAction>
            </AlertDialogFooter>
          </AlertDialogContent>
        </AlertDialog>
      </div>
    </>
  );
};

type FormSubmitProps<FormValues extends FieldValues> = {
  form: UseFormReturn<FormValues>;
  onSubmit: SubmitHandler<FormValues> | undefined;
  errorTitle?: string;
  errorMessage?: string;
};

const Loader2 = motion(LoaderIcon);
const Send = motion(SendIcon);

export const FormSubmit = <FormValues extends FieldValues>(
  props: FormSubmitProps<FormValues>
) => {
  const { form, onSubmit, errorTitle, errorMessage } = props;

  const { toast } = useToast();

  const onError: SubmitErrorHandler<FormValues> = (_error) => {
    toast({
      title: errorTitle ?? 'Attenzione',
      description:
        errorMessage ??
        'Compila tutti gli item del questionario per poter inviare la somministrazione',
      variant: 'warning',
    });
  };

  if (!onSubmit) return null;

  return (
    <Button
      type="button"
      icon="right"
      onClick={form.handleSubmit(onSubmit, onError)}
      disabled={form.formState.isSubmitting}
    >
      <span>Invia</span>
      <AnimatePresence mode="wait">
        {form.formState.isSubmitting ? (
          <Loader2 key="icon" className="ml-1 mr-2 h-4 w-4 animate-spin" />
        ) : (
          <Send key="icon" className="ml-1 mr-2 h-4 w-4 rotate-45" />
        )}
      </AnimatePresence>
    </Button>
  );
};

import { type Prisma } from '@prisma/client';
import { type FieldValues, type SubmitHandler } from 'react-hook-form';

import { useAdministrationContext } from '@/features/questionnaires/context/administration';
import { type available } from '@/features/questionnaires/settings';
import {
  type TContext,
  type TData,
  type TError,
  type TVariables,
} from '@/features/questionnaires/types';
import { usePatient } from '@/hooks/use-patient';
import { useToast } from '@/hooks/use-toast';
import { api } from '@/utils/api';

type Props<FormValues extends FieldValues> = {
  onSuccess?: (
    data: TData,
    variables: TVariables,
    context: TContext | undefined
  ) => Promise<unknown> | unknown;
  onError?: (
    error: TError,
    variables: TVariables,
    context: TContext | undefined
  ) => Promise<unknown> | unknown;
  onSettled?: (
    data: TData | undefined,
    error: TError | null,
    variables: TVariables,
    context: TContext | undefined
  ) => Promise<unknown> | unknown;
  formatRecords: (
    data: FormValues
  ) => Prisma.NullTypes.JsonNull | Prisma.InputJsonValue;
  type: (typeof available)[number];
};

export const useAdministration = <FormValues extends FieldValues>(
  props: Props<FormValues>
) => {
  const { patient, isLoading } = usePatient();
  const { toast } = useToast();
  const { dispatch } = useAdministrationContext();

  const { onSuccess, onError, onSettled, formatRecords, type } = props;

  const defaultOnSuccess = async (data: TData) => {
    dispatch({
      type: 'set_state',
      payload: {
        id: data.id,
        sent: true,
      },
    });
    await utils.patient.invalidate();
  };

  const defaultOnError = (_error: TError) => {
    return toast({
      title: 'Errore',
      description:
        'Si è verificato un errore durante il caricamento della somministrazione, riprova più tardi',
      variant: 'destructive',
    });
  };

  const utils = api.useContext();
  const administration = api.administration.create.useMutation({
    onSuccess: async (data, variables, context) => {
      if (onSuccess) return await onSuccess(data, variables, context);
      return await defaultOnSuccess(data);
    },
    onError: async (error, variables, context) => {
      if (onError) return await onError(error, variables, context);
      return defaultOnError(error);
    },
    onSettled: (data, error, variable, context) => {
      if (onSettled) return onSettled(data, error, variable, context);
    },
  });

  if (!patient || isLoading) return { onSubmit: undefined };

  const onSubmit: SubmitHandler<FormValues> = async (data) => {
    const records = formatRecords(data);

    await administration.mutateAsync({
      data: {
        patientId: patient.id,
        records,
        type,
        medicalRecord: {
          connectOrCreate: {
            where: {
              patientId: patient.id,
            },
            create: {
              patientId: patient.id,
              ongoing: true,
            },
          },
        },
      },
    });
  };

  return { onSubmit };
};

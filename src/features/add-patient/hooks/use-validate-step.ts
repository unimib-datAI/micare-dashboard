import { useEffect, useState } from 'react';
import { useFormContext } from 'react-hook-form';

import {
  type accountSchema,
  type anamnesisSchema,
  type clinicalDataSchema,
  type CreatePatientSchema,
  type interventionSchema,
} from '@/types/zod/schema';

export const useValidateStep = (
  step: number,
  currentStep: number,
  schema:
    | typeof accountSchema
    | typeof anamnesisSchema
    | typeof clinicalDataSchema
    | typeof interventionSchema,
  totalSteps: number
) => {
  const [status, setStatus] = useState<
    'active' | 'inactive' | 'complete' | 'error'
  >();
  const [isTouched, setIsTouched] = useState<boolean[]>(
    Array.from({ length: totalSteps }, () => false)
  );

  const { getValues } = useFormContext<Partial<CreatePatientSchema>>();

  const fieldsKeys = Object.keys(schema.shape) as Array<
    keyof CreatePatientSchema
  >;
  const fieldsValues = getValues(fieldsKeys);
  const stepValues: {
    [key: string]: (typeof fieldsValues)[number];
  } = {};

  fieldsKeys.forEach((key, index) => {
    stepValues[key] = fieldsValues[index];
  });

  useEffect(() => {
    if (!schema || currentStep === undefined) return;

    if (!isTouched[step]) {
      setIsTouched((prev) => {
        prev[currentStep] = true;
        return prev;
      });
    }
    const updateStatus = async () => {
      const isValid = await schema.spa(stepValues);

      if (currentStep === step) return setStatus('active');
      if (!isTouched[step]) return setStatus('inactive');
      if (isValid.success) return setStatus('complete');
      return setStatus('error');
    };

    void updateStatus();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [currentStep]);

  return { status };
};

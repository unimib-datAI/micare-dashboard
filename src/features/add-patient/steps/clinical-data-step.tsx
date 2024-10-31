import { useContext } from 'react';
import { useFormContext, useFormState } from 'react-hook-form';

import { Input } from '@/components/ui/input';
import { WizardContext } from '@/components/ui/wizard';
import { StepWrapper } from '@/features/add-patient/step-wrapper';
import { type CreatePatientSchema } from '@/types/zod/schema';

export const ClinicalData = () => {
  const { register } = useFormContext<CreatePatientSchema>();
  const { errors } = useFormState<CreatePatientSchema>();
  const { currentStep } = useContext(WizardContext);

  return (
    <StepWrapper variant="single">
      <Input
        {...register('diagnosticHypothesis')}
        tabIndex={currentStep !== 2 ? -1 : 0}
        id="diagnosticHypothesis"
        label="Ipotesi diagnostica"
        type="text"
        placeholder="Depressione"
        labelClassName="text-forest-green-700"
        className={
          errors?.diagnosticHypothesis && 'border-red-500 outline-red-500'
        }
        error={errors?.diagnosticHypothesis}
      />
      <Input
        {...register('simptoms')}
        tabIndex={currentStep !== 2 ? -1 : 0}
        id="simptoms"
        label="Sintomi"
        type="textArea"
        rows={5}
        placeholder="Descrizione dei sintomi"
        labelClassName="text-forest-green-700"
        className={errors?.simptoms && 'border-red-500 outline-red-500'}
        error={errors?.simptoms}
      />
    </StepWrapper>
  );
};

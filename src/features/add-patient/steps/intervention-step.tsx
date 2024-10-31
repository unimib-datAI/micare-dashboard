import { useContext } from 'react';
import { Controller, useFormContext, useFormState } from 'react-hook-form';

import { Input } from '@/components/ui/input';
import { WizardContext } from '@/components/ui/wizard';
import { StepWrapper } from '@/features/add-patient/step-wrapper';
import { type CreatePatientSchema } from '@/types/zod/schema';

export const Intervention = () => {
  const { register, control } = useFormContext<CreatePatientSchema>();
  const { errors } = useFormState<CreatePatientSchema>();
  const { currentStep } = useContext(WizardContext);

  return (
    <StepWrapper>
      <Input
        {...register('goals')}
        tabIndex={currentStep !== 3 ? -1 : 0}
        id="goals"
        label="Obiettivi"
        type="textArea"
        placeholder="Descrizione degli obiettivi"
        labelClassName="text-forest-green-700"
        className={errors?.goals && 'border-red-500 outline-red-500'}
        error={errors?.goals}
        containerClassName="col-span-2"
      />
      <Input
        {...register('therapeuticPlan')}
        tabIndex={currentStep !== 3 ? -1 : 0}
        id="therapeuticPlan"
        label="Piano terapeutico"
        type="textArea"
        placeholder="Descrizione del piano terapeutico"
        labelClassName="text-forest-green-700"
        className={errors?.therapeuticPlan && 'border-red-500 outline-red-500'}
        containerClassName="col-span-2"
        error={errors?.therapeuticPlan}
      />
      <Input
        {...register('frequency')}
        tabIndex={currentStep !== 3 ? -1 : 0}
        id="frequency"
        label="Frequenza incontri"
        type="text"
        placeholder="Una volta a settimana"
        labelClassName="text-forest-green-700"
        className={errors?.frequency && 'border-red-500 outline-red-500'}
        error={errors?.frequency}
      />
      <Controller
        control={control}
        name="takingChargeDate"
        defaultValue={new Date()}
        render={({ field }) => {
          const { onChange, value } = field;
          return (
            <Input
              id="takingChargeDate"
              tabIndex={currentStep !== 3 ? -1 : 0}
              label="Data di presa in carico"
              type="date"
              selected={value}
              onSelect={onChange}
              placeholder="mrossi@example.it"
              labelClassName="text-forest-green-700"
              className={
                errors?.takingChargeDate && 'border-red-500 outline-red-500'
              }
              error={errors?.takingChargeDate}
            />
          );
        }}
      />
    </StepWrapper>
  );
};

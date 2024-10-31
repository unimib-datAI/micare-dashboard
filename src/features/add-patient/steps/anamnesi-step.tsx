import { AnimatePresence, motion } from 'framer-motion';
import { type ChangeEvent, useContext } from 'react';
import { Controller, useFormContext, useFormState } from 'react-hook-form';

import { Input } from '@/components/ui/input';
import {
  Select,
  SelectContent,
  SelectGroup,
  SelectItem,
  SelectLabel,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';
import { WizardContext } from '@/components/ui/wizard';
import { StepWrapper } from '@/features/add-patient/step-wrapper';
import { type CreatePatientSchema } from '@/types/zod/schema';
import { cn } from '@/utils/cn';

export const Anamnesi = () => {
  const { register, control } = useFormContext<CreatePatientSchema>();
  const { errors } = useFormState<CreatePatientSchema>();
  const { currentStep } = useContext(WizardContext);

  return (
    <StepWrapper variant="quadruple">
      <Input
        {...register('name')}
        tabIndex={currentStep !== 1 ? -1 : 0}
        id="name"
        label="Nome"
        labelVariant="del"
        labelAltText="ID del paziente"
        type="text"
        // placeholder="Mario Rossi"
        placeholder="23ca8dc1"
        labelClassName="text-forest-green-700"
        containerClassName="col-span-3"
        className={cn(
          'disabled:opacity-100',
          errors?.username && 'border-red-500 outline-red-500'
        )}
        helperText="Nella versione attuale della piattaforma il nome dell'utente è anonimizzato usando l'ID del paziente."
        error={errors?.name}
        disabled
      />

      <Controller
        control={control}
        name="age"
        render={({ field }) => {
          const { onChange, value } = field;
          const transform = {
            input: (value: number) =>
              isNaN(value) || value === 0 ? '' : value.toString(),
            output: (
              e:
                | ChangeEvent<HTMLTextAreaElement>
                | ChangeEvent<HTMLInputElement>
            ) => {
              const output = parseInt(e.target.value, 10);
              return isNaN(output) ? 0 : output;
            },
          };
          return (
            <Input
              id="age"
              tabIndex={currentStep !== 1 ? -1 : 0}
              label="Età"
              type="text"
              placeholder="26"
              labelClassName="text-forest-green-700"
              containerClassName="grow-0"
              className={errors?.age && 'border-red-500 outline-red-500'}
              error={errors?.age}
              onChange={(e) => onChange(transform.output(e))}
              value={transform.input(value)}
            />
          );
        }}
      />

      <Controller
        control={control}
        name="sex"
        render={({ field, fieldState }) => {
          const { error } = fieldState;
          return (
            <SelectGroup className="col-span-2 w-full">
              <SelectLabel className="font-default mb-2 block px-0 pt-0 text-base text-forest-green-700">
                Sesso
              </SelectLabel>
              <Select value={field.value} onValueChange={field.onChange}>
                <SelectTrigger
                  tabIndex={currentStep !== 1 ? -1 : 0}
                  className={cn(!!error && 'border-red-500 outline-red-500')}
                >
                  <SelectValue placeholder="Seleziona il sesso" />
                </SelectTrigger>
                <SelectContent side="bottom">
                  <SelectItem value="M">Maschio</SelectItem>
                  <SelectItem value="F">Femmina</SelectItem>
                </SelectContent>
              </Select>
              <AnimatePresence mode="wait">
                <motion.p
                  key={error?.message}
                  initial={{ y: -10, opacity: 0 }}
                  animate={{ y: 0, opacity: 1 }}
                  exit={{ y: 10, opacity: 0 }}
                  transition={{ duration: 0.2 }}
                  className={cn(
                    'font-small text-slate-500',
                    !!error && 'mt-1',
                    !!error && error.type !== 'CredentialsError'
                      ? 'text-red-500'
                      : ''
                  )}
                >
                  {error?.message}
                </motion.p>
              </AnimatePresence>
            </SelectGroup>
          );
        }}
      />

      <Input
        {...register('pronoun')}
        tabIndex={currentStep !== 1 ? -1 : 0}
        id="pronoun"
        label="Pronome"
        helperText="Lasciare vuoto se il paziente non esprime una preferenza"
        type="text"
        placeholder="Lui/Lei/Loro..."
        labelClassName="text-forest-green-700"
        containerClassName="col-span-2"
        className={errors?.pronoun && 'border-red-500 outline-red-500'}
        error={errors?.pronoun}
      />

      <Input
        {...register('schooling')}
        tabIndex={currentStep !== 1 ? -1 : 0}
        id="schooling"
        label="Scolarità"
        type="text"
        placeholder="Laurea in Informatica"
        labelClassName="text-forest-green-700"
        containerClassName="col-span-2"
        className={errors?.schooling && 'border-red-500 outline-red-500'}
        error={errors?.schooling}
      />
      <Input
        {...register('birthPlace')}
        tabIndex={currentStep !== 1 ? -1 : 0}
        id="birthPlace"
        label="Luogo di nascita"
        type="text"
        placeholder="Milano"
        labelClassName="text-forest-green-700"
        containerClassName="col-span-2"
        className={errors?.birthPlace && 'border-red-500 outline-red-500'}
        error={errors?.birthPlace}
      />
      <Input
        {...register('reason')}
        tabIndex={currentStep !== 1 ? -1 : 0}
        id="reason"
        label="Motivo della presa in carico"
        type="textArea"
        placeholder="Descrizione delle motivazioni"
        labelClassName="text-forest-green-700"
        className={errors?.reason && 'border-red-500 outline-red-500'}
        containerClassName="col-span-4"
        error={errors?.reason}
      />
      <Input
        {...register('previousInterventions')}
        tabIndex={currentStep !== 1 ? -1 : 0}
        id="previousInterventions"
        label="Interventi pregressi"
        type="textArea"
        placeholder="Ricovero in psichiatria nel 2019"
        labelClassName="text-forest-green-700"
        className={
          errors?.previousInterventions && 'border-red-500 outline-red-500'
        }
        containerClassName="col-span-4"
        error={errors?.previousInterventions}
        helperText="Lasciare vuoto se non ci sono stati interventi pregressi"
      />
    </StepWrapper>
  );
};

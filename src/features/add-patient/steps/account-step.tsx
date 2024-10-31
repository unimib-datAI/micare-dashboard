import { useContext, useEffect } from 'react';
import { useFormContext, useFormState } from 'react-hook-form';

import { Input } from '@/components/ui/input';
import { WizardContext } from '@/components/ui/wizard';
import { StepWrapper } from '@/features/add-patient/step-wrapper';
import { type CreatePatientSchema } from '@/types/zod/schema';
import { cn } from '@/utils/cn';

export const Account = () => {
  const { register, setValue, watch } = useFormContext<CreatePatientSchema>();
  const { errors } = useFormState<CreatePatientSchema>();
  const { currentStep } = useContext(WizardContext);

  useEffect(() => {
    /**
     * This is a custom subscription to watch for changes in the username field.
     * In test phase, email is automatically generated from username.
     */
    const subscription = watch((value, { name, type }) => {
      if (name === 'username' && type === 'change') {
        setValue('email', `${value.username ?? ''}@example.it`);
      }
    });
    return () => subscription.unsubscribe();
  }, [watch, setValue]);

  return (
    <StepWrapper
      title="Informazioni personali"
      description="Questi dati serviranno al paziente per accedere all'applicazione."
    >
      <Input
        {...register('username')}
        tabIndex={currentStep !== 0 ? -1 : 0}
        id="username"
        label="Username"
        labelVariant="del"
        labelAltText="ID del paziente"
        type="text"
        // placeholder="mrossi"
        placeholder="23ca8dc1"
        labelClassName="text-forest-green-700"
        containerClassName="col-span-2"
        className={cn(
          'disabled:opacity-100',
          errors?.username && 'border-red-500 outline-red-500'
        )}
        error={errors?.username}
        helperText="La versione attuale della piattaforma non permette la raccolta di dati identificativi dell'utente. Copia questo ID nella cartella del paziente; potrai utilizzarlo per ricercare il paziente all'interno di questa piattaforma."
        disabled
      />
      <Input
        {...register('email')}
        tabIndex={currentStep !== 0 ? -1 : 0}
        id="email"
        label="Email"
        type="email"
        placeholder="mrossi@example.it"
        labelClassName="text-forest-green-700"
        className={errors?.email && 'border-red-500 outline-red-500'}
        disabled
        error={errors?.email}
        helperText="Disabilitato in fase di test per privacy."
      />
      {/* <Input
        {...register('password')}
        id="password"
        label="Password"
        type="password"
        placeholder="**********"
        labelClassName="text-forest-green-700"
        className={errors?.password && 'border-red-500 outline-red-500'}
        error={errors?.password}
        helperText="La password deve contenere almeno 6 caratteri"
      />
      <Input
        {...register('confirmPassword')}
        id="confirmPassword"
        label="Conferma la password"
        type="password"
        placeholder="**********"
        labelClassName="text-forest-green-700"
        className={errors?.confirmPassword && 'border-red-500 outline-red-500'}
        error={errors?.confirmPassword}
      /> */}
      <Input
        {...register('phone')}
        tabIndex={currentStep !== 0 ? -1 : 0}
        id="phone"
        label="Telefono"
        type="text"
        placeholder="3401234567"
        defaultValue="3401234567"
        labelClassName="text-forest-green-700"
        className={errors?.phone && 'border-red-500 outline-red-500'}
        disabled
        error={errors?.phone}
        helperText="Disabilitato in fase di test per privacy."
      />
      <Input
        {...register('address')}
        tabIndex={currentStep !== 0 ? -1 : 0}
        id="address"
        label="Residenza"
        type="text"
        defaultValue="Via ignota 3, Milano (MI)"
        placeholder="Via Ignota 3, Milano (MI)"
        labelClassName="text-forest-green-700"
        containerClassName="col-span-2"
        className={errors?.address && 'border-red-500 outline-red-500'}
        error={errors?.address}
        disabled
        helperText="Disabilitato in fase di test per privacy."
      />
    </StepWrapper>
  );
};

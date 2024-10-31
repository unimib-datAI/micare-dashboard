import { zodResolver } from '@hookform/resolvers/zod';
import { AnimatePresence, motion } from 'framer-motion';
import {
  ChevronLeft,
  ChevronRight,
  Loader2 as LoaderIcon,
  Save as SaveIcon,
} from 'lucide-react';
import {
  type DetailedHTMLProps,
  type FormHTMLAttributes,
  useState,
} from 'react';
import {
  FormProvider,
  type SubmitErrorHandler,
  type SubmitHandler,
  useForm,
} from 'react-hook-form';

import { Button } from '@/components/ui/button';
import {
  Wizard,
  WizardContent,
  WizardHeader,
  WizardNavigation,
  WizardStep,
  WizardStepper,
} from '@/components/ui/wizard';
import { useToast } from '@/hooks/use-toast';
import {
  accountSchema,
  anamnesisSchema,
  clinicalDataSchema,
  type CreatePatientSchema,
  createPatientSchema,
  interventionSchema,
} from '@/types/zod/schema';
import { api } from '@/utils/api';

import { Account, Anamnesi, ClinicalData, Intervention } from './steps';

type Props = DetailedHTMLProps<
  FormHTMLAttributes<HTMLFormElement>,
  HTMLFormElement
> & {
  close: () => void;
};

const Loader2 = motion(LoaderIcon);
const Save = motion(SaveIcon);

const STEPS = [
  { label: 'Account', component: Account, schema: accountSchema },
  { label: 'Anamnesi', component: Anamnesi, schema: anamnesisSchema },
  {
    label: 'Dati clinici',
    component: ClinicalData,
    schema: clinicalDataSchema,
  },
  { label: 'Intervento', component: Intervention, schema: interventionSchema },
];

export const Form = (props: Props) => {
  const { close, ...rest } = props;
  const [step, setStep] = useState(0);
  const uuid = crypto.randomUUID().split('-')[0];

  const methods = useForm<CreatePatientSchema>({
    mode: 'onChange',
    reValidateMode: 'onChange',
    shouldUnregister: true,
    resolver: zodResolver(createPatientSchema),
    defaultValues: {
      name: uuid,
      username: uuid,
      email: `${uuid}@example.it`,
      phone: '3401234567',
      address: 'Via Roma 1',
    },
  });

  const handleNext = () => {
    setStep((prevStep) => prevStep + 1);
  };

  const handleBack = () => {
    setStep((prevStep) => prevStep - 1);
  };

  const goToStep = (step: number) => {
    setStep(step);
  };

  const utils = api.useContext();
  const createPatient = api.patient.create.useMutation({
    onSuccess: async () => {
      console.log('success');
      toast({
        title: 'Successo',
        description: 'Il paziente è stato aggiunto con successo, ',
      });

      await utils.therapist.invalidate();
      return close();
    },
    onError: (_error) => {
      return toast({
        title: 'Errore',
        description:
          'Si è verificato un errore durante la creazione del paziente, riprova più tardi',
        variant: 'destructive',
      });
    },
  });
  const { toast } = useToast();

  const onError: SubmitErrorHandler<CreatePatientSchema> = (_error) => {
    toast({
      title: 'Attenzione',
      description:
        'Alcuni campi non sono validi, correggi gli errori e riprova',
      variant: 'warning',
    });
  };

  const onSubmit: SubmitHandler<CreatePatientSchema> = async (data) => {
    await createPatient.mutateAsync({
      user: {
        create: {
          email: data.email,
          address: data.address,
          name: data.name,
          roles: ['patient'],
          phone: data.phone,
          username: data.username,
        },
      },
      medicalRecord: {
        create: {
          anamnesticData: {
            create: {
              age: data.age,
              sex: data.sex,
              pronoun: data.pronoun ?? data.sex === 'M' ? 'Lui' : 'Lei',
              schooling: data.schooling,
              birthPlace: data.birthPlace,
              previousInterventions: data.previousInterventions,
              reason: data.reason,
            },
          },
          clinicalData: {
            create: {
              diagnosticHypothesis: data.diagnosticHypothesis,
              simptoms: data.simptoms,
            },
          },
          intervention: {
            create: {
              frequency: data.frequency,
              goals: data.goals,
              therapeuticPlan: data.therapeuticPlan,
              takingChargeDate: data.takingChargeDate,
            },
          },
          ongoing: true,
        },
      },
    });
  };

  return (
    <FormProvider {...methods}>
      <form onSubmit={methods.handleSubmit(onSubmit, onError)} {...rest}>
        <Wizard
          currentStep={step}
          totalStep={STEPS.length}
          className="grid grid-rows-[auto,1fr,auto]"
        >
          <WizardHeader>
            <WizardStepper className="py-3">
              {STEPS.map((step, index) => {
                const label = step.label;
                return (
                  <button
                    type="button"
                    key={index}
                    onClick={() => goToStep(index)}
                  >
                    <WizardStep step={index} schema={step.schema}>
                      {label}
                    </WizardStep>
                  </button>
                );
              })}
            </WizardStepper>
          </WizardHeader>
          <WizardContent className="overflow-y-auto py-6">
            {STEPS.map((step, index) => (
              <step.component key={index} />
            ))}
          </WizardContent>
          <WizardNavigation>
            {step > 0 && (
              <Button type="button" icon="left" onClick={handleBack}>
                <ChevronLeft className="mr-2" />
                Indietro
              </Button>
            )}
            {step < STEPS.length - 1 && (
              <Button
                type="button"
                icon="right"
                onClick={handleNext}
                className="ml-auto"
              >
                Avanti
                <ChevronRight className="ml-2" />
              </Button>
            )}
            {step === STEPS.length - 1 && (
              <Button
                type="submit"
                icon="right"
                className="ml-auto"
                disabled={methods.formState.isSubmitting}
              >
                Salva
                <AnimatePresence mode="wait">
                  {methods.formState.isSubmitting ? (
                    <Loader2 className="ml-2 animate-spin" />
                  ) : (
                    <Save className="ml-2" />
                  )}
                </AnimatePresence>
              </Button>
            )}
          </WizardNavigation>
        </Wizard>
      </form>
    </FormProvider>
  );
};

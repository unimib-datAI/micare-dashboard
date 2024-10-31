import { zodResolver } from '@hookform/resolvers/zod';
import { format } from 'date-fns';
import { motion } from 'framer-motion';
import {
  Calendar,
  Clock,
  Edit,
  Milestone,
  Save,
  Target,
  X,
} from 'lucide-react';
import { useContext } from 'react';
import {
  Controller,
  type SubmitErrorHandler,
  type SubmitHandler,
  useForm,
} from 'react-hook-form';

import { Button } from '@/components/ui/button';
import {
  Card,
  CardContent,
  CardFooter,
  CardHeader,
  CardTitle,
} from '@/components/ui/card';
import { Input } from '@/components/ui/input';
import { Separator } from '@/components/ui/separator';
import { DataWrapper } from '@/features/medical-records/components/data-wrapper';
import { MedicalRecordsContext } from '@/features/medical-records/contexts/medical-records';
import { usePatient } from '@/hooks/use-patient';
import { toast } from '@/hooks/use-toast';
import {
  type InterventionSchema,
  interventionSchema,
} from '@/types/zod/schema';
import { api } from '@/utils/api';
import { cn } from '@/utils/cn';

const MotionCard = motion(Card);

export const Intervention = () => {
  const { patient, isLoading } = usePatient();
  const { selected, setSelected, variants } = useContext(MedicalRecordsContext);
  const isSelected = selected === 'intervention';

  const {
    control,
    register,
    reset,
    handleSubmit,
    formState: { errors },
  } = useForm<InterventionSchema>({
    resolver: zodResolver(interventionSchema),
  });

  const utils = api.useContext();
  const updateIntervention = api.patient.update.useMutation({
    onSuccess: async () => {
      console.log('success');
      toast({
        title: 'Successo',
        description: 'Il paziente è stato aggiornato con successo.',
      });

      await utils.patient.invalidate();
      reset();
      return setSelected(null);
    },
    onError: (_error) => {
      return toast({
        title: 'Errore',
        description:
          "Si è verificato un errore l'aggiornamento del paziente, riprova più tardi",
        variant: 'destructive',
      });
    },
  });

  if (!patient || isLoading) return null;

  const onSubmit: SubmitHandler<InterventionSchema> = async (data) => {
    await updateIntervention.mutateAsync({
      where: { id: patient.id },
      data: {
        medicalRecord: {
          update: {
            intervention: {
              update: {
                ...data,
              },
            },
          },
        },
      },
    });
  };

  const onError: SubmitErrorHandler<InterventionSchema> = (_error) => {
    toast({
      title: 'Attenzione',
      description:
        'Alcuni campi non sono validi, correggi gli errori e riprova',
      variant: 'warning',
    });
  };

  return (
    <MotionCard
      className="m-auto h-fit w-[65ch] origin-center"
      layout="position"
      layoutId="intervention"
      initial="unselected"
      exit="unselected"
      animate={isSelected ? 'selected' : 'unselected'}
      variants={variants}
    >
      <motion.form onSubmit={handleSubmit(onSubmit, onError)} layout="position">
        <CardHeader className="pb-3">
          <CardTitle className="flex items-center justify-between text-base">
            Intervento
            <Button
              variant="ghost"
              type="button"
              size="icon"
              onClick={() => {
                reset();
                setSelected((selected) => (selected ? null : 'intervention'));
              }}
            >
              {isSelected ? (
                <X className="h-4 w-4 text-red-500" />
              ) : (
                <Edit className="h-4 w-4 text-forest-green-700" />
              )}
            </Button>
          </CardTitle>
        </CardHeader>
        <CardContent className="flex flex-col gap-3">
          <div className="grid grid-cols-2 items-center justify-items-start gap-6">
            <div
              className={cn(
                !isSelected &&
                  'grid grid-cols-[repeat(2,_minmax(0,max-content))] place-items-start gap-2'
              )}
            >
              <DataWrapper label="Frequenza sedute" Icon={Clock}>
                {!isSelected ? (
                  patient.medicalRecord?.intervention?.frequency
                ) : (
                  <Input
                    {...register('frequency')}
                    defaultValue={
                      patient?.medicalRecord?.intervention?.frequency
                    }
                    id="frequency"
                    type="text"
                    placeholder="Una volta a settimana"
                    className={cn(
                      'text-sm',
                      errors?.frequency && 'border-red-500 outline-red-500'
                    )}
                    error={errors?.frequency}
                  />
                )}
              </DataWrapper>
            </div>
            <div
              className={cn(
                !isSelected &&
                  'grid grid-cols-[repeat(2,_minmax(0,max-content))] place-items-start gap-2 place-self-end'
              )}
            >
              <DataWrapper label="Data presa in carico" Icon={Calendar}>
                {!isSelected ? (
                  patient.medicalRecord?.intervention?.takingChargeDate &&
                  format(
                    patient.medicalRecord?.intervention?.takingChargeDate,
                    'P'
                  )
                ) : (
                  <Controller
                    control={control}
                    name="takingChargeDate"
                    defaultValue={
                      patient?.medicalRecord?.intervention?.takingChargeDate
                    }
                    render={({ field }) => {
                      const { onChange, value } = field;
                      return (
                        <Input
                          id="takingChargeDate"
                          type="date"
                          selected={value}
                          onSelect={onChange}
                          placeholder="mrossi@example.it"
                          className={cn(
                            'text-sm',
                            errors?.takingChargeDate &&
                              'border-red-500 outline-red-500'
                          )}
                          error={errors?.takingChargeDate}
                        />
                      );
                    }}
                  />
                )}
              </DataWrapper>
            </div>
          </div>
          <Separator />
          <div>
            <DataWrapper label="Obiettivi" Icon={Target} type="long">
              {!isSelected ? (
                patient.medicalRecord?.intervention?.goals
              ) : (
                <Input
                  {...register('goals')}
                  defaultValue={patient?.medicalRecord?.intervention?.goals}
                  id="goals"
                  type="textArea"
                  placeholder="Descrizione degli obiettivi"
                  className={cn(
                    'text-sm',
                    errors?.therapeuticPlan && 'border-red-500 outline-red-500'
                  )}
                  containerClassName="col-span-2"
                  error={errors?.therapeuticPlan}
                />
              )}
            </DataWrapper>
          </div>
          <div>
            <DataWrapper label="Piano terapeutico" Icon={Milestone} type="long">
              {!isSelected ? (
                patient.medicalRecord?.intervention?.therapeuticPlan
              ) : (
                <Input
                  {...register('therapeuticPlan')}
                  defaultValue={
                    patient?.medicalRecord?.intervention?.therapeuticPlan
                  }
                  id="therapeuticPlan"
                  type="textArea"
                  placeholder="Descrizione del piano terapeutico"
                  className={cn(
                    'text-sm',
                    errors?.therapeuticPlan && 'border-red-500 outline-red-500'
                  )}
                  containerClassName="col-span-2"
                  error={errors?.therapeuticPlan}
                />
              )}
            </DataWrapper>
          </div>
        </CardContent>
        {isSelected && (
          <CardFooter className="flex justify-end gap-6">
            <Button
              variant="link"
              className="text-red-500"
              type="reset"
              onClick={() => {
                reset();
                setSelected((selected) => (selected ? null : 'intervention'));
              }}
            >
              <span className="ml-2 text-sm">Annulla</span>
            </Button>
            <Button type="submit" icon="right">
              <span className="mr-2 text-sm">Salva</span>
              <Save className="h-4 w-4" />
            </Button>
          </CardFooter>
        )}
      </motion.form>
    </MotionCard>
  );
};

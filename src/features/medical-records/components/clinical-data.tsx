import { zodResolver } from '@hookform/resolvers/zod';
import { motion } from 'framer-motion';
import { ClipboardList, Edit, HelpCircle, Save, X } from 'lucide-react';
import { useContext } from 'react';
import {
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
import { DataWrapper } from '@/features/medical-records/components/data-wrapper';
import { MedicalRecordsContext } from '@/features/medical-records/contexts/medical-records';
import { usePatient } from '@/hooks/use-patient';
import { toast } from '@/hooks/use-toast';
import {
  type ClinicalDataSchema,
  clinicalDataSchema,
} from '@/types/zod/schema';
import { api } from '@/utils/api';
import { cn } from '@/utils/cn';

const MotionCard = motion(Card);

export const ClinicalData = () => {
  const { patient, isLoading } = usePatient();
  const { selected, setSelected, variants } = useContext(MedicalRecordsContext);
  const isSelected = selected === 'clinical-data';

  const {
    register,
    reset,
    handleSubmit,
    formState: { errors },
  } = useForm<ClinicalDataSchema>({
    resolver: zodResolver(clinicalDataSchema),
  });

  const utils = api.useContext();
  const updateClinicalData = api.patient.update.useMutation({
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

  const onSubmit: SubmitHandler<ClinicalDataSchema> = async (data) => {
    await updateClinicalData.mutateAsync({
      where: { id: patient.id },
      data: {
        medicalRecord: {
          update: {
            clinicalData: {
              update: {
                ...data,
              },
            },
          },
        },
      },
    });
  };

  const onError: SubmitErrorHandler<ClinicalDataSchema> = (_error) => {
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
      layoutId="clinical-data"
      initial="unselected"
      exit="unselected"
      animate={isSelected ? 'selected' : 'unselected'}
      variants={variants}
    >
      <motion.form onSubmit={handleSubmit(onSubmit, onError)} layout="position">
        <CardHeader className="pb-3">
          <CardTitle className="flex items-center justify-between text-base">
            Dati clinici
            <Button
              variant="ghost"
              type="button"
              size="icon"
              onClick={() => {
                reset();
                setSelected((selected) => (selected ? null : 'clinical-data'));
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
          <div>
            <DataWrapper
              label="Ipotesi diagnostica"
              Icon={HelpCircle}
              type="long"
            >
              {!isSelected ? (
                patient.medicalRecord?.clinicalData?.diagnosticHypothesis
              ) : (
                <Input
                  {...register('diagnosticHypothesis')}
                  defaultValue={
                    patient.medicalRecord?.clinicalData?.diagnosticHypothesis
                  }
                  id="diagnosticHypothesis"
                  type="text"
                  placeholder="Depressione"
                  className={cn(
                    'text-sm',
                    errors?.diagnosticHypothesis &&
                      'border-red-500 outline-red-500'
                  )}
                  error={errors?.diagnosticHypothesis}
                />
              )}
            </DataWrapper>
          </div>
          <div>
            <DataWrapper label="Sintomi" Icon={ClipboardList} type="long">
              {!isSelected ? (
                patient.medicalRecord?.clinicalData?.simptoms
              ) : (
                <Input
                  {...register('simptoms')}
                  id="simptoms"
                  defaultValue={patient.medicalRecord?.clinicalData?.simptoms}
                  type="textArea"
                  rows={5}
                  placeholder="Descrizione dei sintomi"
                  className={cn(
                    'text-sm',
                    errors?.simptoms && 'border-red-500 outline-red-500'
                  )}
                  error={errors?.simptoms}
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

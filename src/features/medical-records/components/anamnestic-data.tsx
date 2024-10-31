import { zodResolver } from '@hookform/resolvers/zod';
import { motion } from 'framer-motion';
import {
  Baby,
  Cake,
  Edit,
  FileText,
  GraduationCap,
  Heart,
  History,
  MapPin,
  Save,
  X,
} from 'lucide-react';
import { type ChangeEvent, useContext } from 'react';
import {
  Controller,
  type SubmitErrorHandler,
  type SubmitHandler,
  useForm,
} from 'react-hook-form';
import { z } from 'zod';

import { Button } from '@/components/ui/button';
import {
  Card,
  CardContent,
  CardFooter,
  CardHeader,
  CardTitle,
} from '@/components/ui/card';
import { Input } from '@/components/ui/input';
import {
  Select,
  SelectContent,
  SelectGroup,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';
import { Separator } from '@/components/ui/separator';
import { DataWrapper } from '@/features/medical-records/components/data-wrapper';
import { MedicalRecordsContext } from '@/features/medical-records/contexts/medical-records';
import { usePatient } from '@/hooks/use-patient';
import { toast } from '@/hooks/use-toast';
import {
  type AnamnesisSchema as AnamnesisSchemaWhitouthAddress,
  anamnesisSchema as anamnesisSchemaWithoutAddress,
} from '@/types/zod/schema';
import { api } from '@/utils/api';
import { cn } from '@/utils/cn';

const MotionCard = motion(Card);

interface AnamnesisSchema extends Omit<AnamnesisSchemaWhitouthAddress, 'name'> {
  address: string;
}

const anamnesisSchema = anamnesisSchemaWithoutAddress.extend({
  name: z.optional(z.string()),
  address: z.string().nonempty({ message: 'Campo obbligatorio' }),
});

export const AnamnesticData = () => {
  const { patient, isLoading } = usePatient();
  const { selected, setSelected, variants } = useContext(MedicalRecordsContext);
  const isSelected = selected === 'anamnestic-data';

  const {
    control,
    register,
    reset,
    handleSubmit,
    formState: { errors },
  } = useForm<AnamnesisSchema>({
    resolver: zodResolver(anamnesisSchema),
  });

  const utils = api.useContext();
  const updateAnamnesticData = api.patient.update.useMutation({
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

  const onSubmit: SubmitHandler<AnamnesisSchema> = async (data) => {
    await updateAnamnesticData.mutateAsync({
      where: { id: patient.id },
      data: {
        user: {
          update: {
            address: data.address,
          },
        },
        medicalRecord: {
          update: {
            anamnesticData: {
              update: {
                age: data.age,
                birthPlace: data.birthPlace,
                previousInterventions: data.previousInterventions,
                schooling: data.schooling,
                reason: data.reason,
                sex: data.sex,
                pronoun: data.pronoun,
              },
            },
          },
        },
      },
    });
  };

  const onError: SubmitErrorHandler<AnamnesisSchema> = (_error) => {
    console.log(_error);
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
      layoutId="anamnestic-data"
      initial="unselected"
      exit="unselected"
      animate={isSelected ? 'selected' : 'unselected'}
      variants={variants}
    >
      <motion.form onSubmit={handleSubmit(onSubmit, onError)} layout="position">
        <CardHeader className="pb-3">
          <CardTitle className="flex items-center justify-between text-base">
            Dati Anamnestici
            <Button
              variant="ghost"
              type="button"
              size="icon"
              onClick={() => {
                reset();
                setSelected((selected) =>
                  selected ? null : 'anamnestic-data'
                );
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
          <div
            className={cn(
              'grid grid-cols-[repeat(2,_minmax(0,max-content))] place-items-start gap-6',
              isSelected && 'grid-cols-2'
            )}
          >
            <div
              className={cn(
                'grid grid-cols-[repeat(2,_minmax(0,max-content))] items-center justify-items-start gap-2',
                isSelected && 'w-full grid-cols-[minmax(0,max-content)_1fr]'
              )}
            >
              <DataWrapper label="Età" Icon={Cake}>
                {!isSelected ? (
                  patient.medicalRecord?.anamnesticData?.age
                ) : (
                  <Controller
                    control={control}
                    name="age"
                    defaultValue={patient.medicalRecord?.anamnesticData?.age}
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
                          type="text"
                          placeholder="26"
                          containerClassName="grow-0"
                          className={cn(
                            'text-sm',
                            errors?.age && 'border-red-500 outline-red-500'
                          )}
                          error={errors?.age}
                          onChange={(e) => onChange(transform.output(e))}
                          value={transform.input(value)}
                        />
                      );
                    }}
                  />
                )}
              </DataWrapper>
              <DataWrapper label="Sesso" Icon={Heart}>
                {!isSelected ? (
                  patient.medicalRecord?.anamnesticData?.sex === 'M' ? (
                    'Maschio'
                  ) : (
                    'Femmina'
                  )
                ) : (
                  <Controller
                    control={control}
                    name="sex"
                    defaultValue={patient.medicalRecord?.anamnesticData?.sex}
                    render={({ field }) => {
                      return (
                        <SelectGroup className="w-full">
                          <Select
                            value={field.value}
                            onValueChange={field.onChange}
                          >
                            <SelectTrigger className="text-sm">
                              <SelectValue placeholder="Sesso" />
                            </SelectTrigger>
                            <SelectContent>
                              <SelectItem value="M">Maschio</SelectItem>
                              <SelectItem value="F">Femmina</SelectItem>
                            </SelectContent>
                          </Select>
                        </SelectGroup>
                      );
                    }}
                  />
                )}
              </DataWrapper>

              <DataWrapper label="Pronome" Icon={GraduationCap}>
                {!isSelected ? (
                  patient.medicalRecord?.anamnesticData?.pronoun
                ) : (
                  <Input
                    {...register('pronoun')}
                    id="pronoun"
                    type="text"
                    placeholder="Lui/Lei"
                    defaultValue={
                      patient.medicalRecord?.anamnesticData?.pronoun
                    }
                    containerClassName="col-span-2"
                    className={cn(
                      'text-sm',
                      errors?.pronoun && 'border-red-500 outline-red-500'
                    )}
                    error={errors?.pronoun}
                  />
                )}
              </DataWrapper>
            </div>

            <div
              className={cn(
                'grid grid-cols-[repeat(2,_minmax(0,max-content))] items-center justify-items-start gap-2',
                isSelected && 'w-full grid-cols-[minmax(0,max-content)_1fr]'
              )}
            >
              <DataWrapper label="Scolarità" Icon={GraduationCap}>
                {!isSelected ? (
                  patient.medicalRecord?.anamnesticData?.schooling
                ) : (
                  <Input
                    {...register('schooling')}
                    defaultValue={
                      patient.medicalRecord?.anamnesticData?.schooling
                    }
                    id="schooling"
                    type="text"
                    placeholder="Laurea in Informatica"
                    className={cn(
                      'text-sm',
                      errors?.schooling && 'border-red-500 outline-red-500'
                    )}
                    error={errors?.schooling}
                  />
                )}
              </DataWrapper>
              <DataWrapper label="Indirizzo" Icon={MapPin}>
                {!isSelected ? (
                  patient.user?.address
                ) : (
                  <Input
                    {...register('address')}
                    defaultValue={
                      patient.user?.address !== null
                        ? patient.user?.address
                        : ''
                    }
                    id="birthPlace"
                    type="text"
                    placeholder="Milano"
                    className={cn(
                      'text-sm',
                      errors?.address && 'border-red-500 outline-red-500'
                    )}
                    error={errors?.address}
                  />
                )}
              </DataWrapper>
              <DataWrapper label="Nato/a a" Icon={Baby}>
                {!isSelected ? (
                  patient.medicalRecord?.anamnesticData?.birthPlace
                ) : (
                  <Input
                    {...register('birthPlace')}
                    defaultValue={
                      patient.medicalRecord?.anamnesticData?.birthPlace
                    }
                    id="birthPlace"
                    type="text"
                    placeholder="Milano"
                    className={cn(
                      'text-sm',
                      errors?.birthPlace && 'border-red-500 outline-red-500'
                    )}
                    error={errors?.birthPlace}
                  />
                )}
              </DataWrapper>
            </div>
          </div>

          <Separator />

          <div>
            <DataWrapper
              label="Motivo della presa in carico"
              Icon={FileText}
              type="long"
            >
              {!isSelected ? (
                patient.medicalRecord?.anamnesticData?.reason
              ) : (
                <Input
                  {...register('reason')}
                  defaultValue={patient.medicalRecord?.anamnesticData?.reason}
                  id="reason"
                  type="textArea"
                  placeholder="Descrizione delle motivazioni"
                  className={cn(
                    'text-sm',
                    errors?.reason && 'border-red-500 outline-red-500'
                  )}
                  containerClassName="col-span-2"
                  error={errors?.reason}
                />
              )}
            </DataWrapper>
          </div>
          <div>
            <DataWrapper
              label="Interventi precedenti"
              Icon={History}
              type="long"
            >
              {!isSelected ? (
                patient.medicalRecord?.anamnesticData?.previousInterventions
              ) : (
                <Input
                  {...register('previousInterventions')}
                  defaultValue={
                    patient.medicalRecord?.anamnesticData?.previousInterventions
                  }
                  id="previousInterventions"
                  type="textArea"
                  placeholder="Ricovero in psichiatria nel 2019"
                  className={cn(
                    'text-sm',
                    errors?.previousInterventions &&
                      'border-red-500 outline-red-500'
                  )}
                  containerClassName="col-span-2"
                  error={errors?.previousInterventions}
                  helperText="Lasciare vuoto se non ci sono stati interventi pregressi"
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

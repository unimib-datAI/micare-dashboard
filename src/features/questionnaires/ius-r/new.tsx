import { zodResolver } from '@hookform/resolvers/zod';
import { useForm } from 'react-hook-form';

import {
  FormContent,
  FormFooter,
  FormHeader,
  FormInstructions,
  FormSubmit,
} from '@/features/questionnaires/components/form';
import { useAdministration } from '@/features/questionnaires/hooks/use-administration-submit';
import {
  formSchema,
  type FormValues,
  Item,
} from '@/features/questionnaires/ius-r/item';
import { QUESTIONS } from '@/features/questionnaires/ius-r/questions';

const NewAdministration = () => {
  const form = useForm<FormValues>({
    resolver: zodResolver(formSchema),
  });

  const formatRecords = (data: FormValues) => {
    return {
      score: {
        prospective: +Object.entries(data.response).reduce(
          (acc, [index, value]) => {
            const id = index.split('-')[1];
            if (id === undefined) {
              throw new Error('Invalid index');
            }
            if (+id > 8) return acc;
            return [acc[0], `${parseInt(acc[1]) + parseInt(value)}`];
          }
        )[1],
        inhibitory: +Object.entries(data.response).reduce(
          (acc, [index, value]) => {
            const id = index.split('-')[1];
            if (id === undefined) {
              throw new Error('Invalid index');
            }
            if (+id < 9) return acc;
            return [acc[0], `${parseInt(acc[1]) + parseInt(value)}`];
          }
        )[1],
      },
      response: data.response,
    };
  };

  const { onSubmit } = useAdministration<FormValues>({
    formatRecords,
    type: 'ius-r',
  });

  return (
    <FormContent<FormValues>
      form={form}
      title="Intolerance of Uncertainty Scale-Revised (IUS-R)"
    >
      <FormHeader>
        <FormInstructions>
          <p>
            Di seguito troverà una serie di affermazioni. La preghiamo di
            leggere attentamente ciascuna affermazione e di indicare quella che
            meglio la descrive.
          </p>
        </FormInstructions>
        <ul className="flex items-end justify-end gap-2 pr-4 text-forest-green-700">
          <li className="flex w-10 rotate-180 items-center text-sm [writing-mode:vertical-rl]">
            Per niente d&apos;accordo
          </li>
          <li className="flex w-10 rotate-180 items-center text-sm [writing-mode:vertical-rl]">
            Un po&apos; d&apos;accordo
          </li>
          <li className="flex w-10 rotate-180 items-center text-sm [writing-mode:vertical-rl]">
            Moderatamente d&apos;accordo
          </li>
          <li className="flex w-10 rotate-180 items-center text-sm [writing-mode:vertical-rl]">
            Molto d&apos;accordo
          </li>
          <li className="flex w-10 rotate-180 items-center text-sm [writing-mode:vertical-rl]">
            Completamente d&apos;accordo
          </li>
        </ul>
      </FormHeader>
      {QUESTIONS.map((question, index) => (
        <Item key={index} question={question} />
      ))}
      <FormFooter type="ius-r" className="justify-end">
        <FormSubmit form={form} onSubmit={onSubmit} />
      </FormFooter>
    </FormContent>
  );
};

export default NewAdministration;

import { zodResolver } from '@hookform/resolvers/zod';
import { useForm } from 'react-hook-form';

import {
  CbaVeItem,
  formSchema,
  type FormValues,
} from '@/features/questionnaires/cba-ve/cba-ve-item';
import { QUESTIONS } from '@/features/questionnaires/cba-ve/cbave-questions';
import {
  FormContent,
  FormFooter,
  FormSubmit,
} from '@/features/questionnaires/components/form';
import { useAdministration } from '@/features/questionnaires/hooks/use-administration-submit';
import { getScores } from '@/utils/administrationScores';

const NewAdministration = () => {
  const form = useForm<FormValues>({
    resolver: zodResolver(formSchema),
  });

  const formatRecords = (data: FormValues) => {
    return {
      scores: getScores(data),
      response: data,
    };
  };

  const { onSubmit } = useAdministration<FormValues>({
    formatRecords,
    type: 'pdss',
  });

  return (
    <FormContent<FormValues>
      form={form}
      title="Cognitive Behavioural Assessment - Valutazione dell'esito (CBA-VE)"
    >
      {QUESTIONS.map((section, index) => (
        <section key={index.toString()} className="pb-4">
          <header className="sticky top-0 bg-gray-10 pb-3">
            <p className="mb-4 rounded-md bg-white p-4">
              {section.instruction}
            </p>
            <ul className="flex justify-end gap-2 pr-4 text-forest-green-700">
              <li className="w-20 text-center text-sm">Per nulla</li>
              <li className="w-20 text-center text-sm">Poco</li>
              <li className="w-20 text-center text-sm">Abbastanza</li>
              <li className="w-20 text-center text-sm">Molto</li>
              <li className="w-20 text-center text-sm">Moltissimo</li>
            </ul>
          </header>
          {section.questions.map((question) => (
            <CbaVeItem
              key={question.index}
              question={question.text}
              index={question.index}
            />
          ))}
        </section>
      ))}
      <FormFooter type="cba-ve" className="justify-end">
        <FormSubmit form={form} onSubmit={onSubmit} />
      </FormFooter>
    </FormContent>
  );
};

export default NewAdministration;

import { type NextPage } from 'next';
import { useRouter } from 'next/router';
import { useForm } from 'react-hook-form';

import { Form } from '@/components/ui/form';
import {
  CbaVeItem,
  type FormValues,
} from '@/features/questionnaires/cba-ve/cba-ve-item';
import { QUESTIONS } from '@/features/questionnaires/cba-ve/cbave-questions';
import { _default as RootLayout, PatientLayout } from '@/layout';
import { type CbaRecord } from '@/types/cba-records';
import { type TView } from '@/types/view-types';
import { api } from '@/utils/api';

const ShowSingleAdministration: NextPage = () => {
  const { query } = useRouter();
  const { view } = query;
  const [_, idTest] = view as TView;
  const {
    data: records,
    isLoading,
    isFetching,
  } = api.administration.findUnique.useQuery(
    {
      where: { id: idTest },
    },
    {
      select: (data) => data.administration.records as unknown as CbaRecord,
    }
  );
  const response = records?.response ?? null;

  const form = useForm<FormValues>();

  if (!response || isLoading || isFetching) return null;

  return (
    <div className="grid h-[calc(100dvh_-_theme(spacing.6)_-_theme(spacing.32))] grid-rows-[auto_1fr_auto]">
      <Form {...form}>
        <header className="sticky top-32 mx-auto max-w-prose pb-3">
          <h1 className="font-h1 leading-tight">
            Cognitive Behavioural Assessment - Valutazione dell&apos;esito
            (CBA-VE)
          </h1>
          <p className="font-h3 absolute -right-28 top-80 z-20 rotate-90">
            (sola visualizzazione)
          </p>
        </header>
        <div className=" overflow-y-auto pb-8">
          <form className="mx-auto max-w-prose space-y-6">
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
                {section.questions.map((question) => {
                  return (
                    <CbaVeItem
                      key={question.index}
                      question={question.text}
                      index={question.index}
                      defaultValue={response?.[`item-${question.index}`]}
                    />
                  );
                })}
              </section>
            ))}
          </form>
        </div>
      </Form>
    </div>
  );
};

export default ShowSingleAdministration;

ShowSingleAdministration.getLayout = (page) => {
  return (
    <RootLayout>
      <PatientLayout>{page}</PatientLayout>
    </RootLayout>
  );
};

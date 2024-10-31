import { type NextPage } from 'next';
import { useRouter } from 'next/router';
import { useForm } from 'react-hook-form';

import { Form } from '@/components/ui/form';
import { type FormValues, Item } from '@/features/questionnaires/gad-7/item';
import { QUESTIONS } from '@/features/questionnaires/gad-7/questions';
import { _default as RootLayout, PatientLayout } from '@/layout';
import { type TView } from '@/types/view-types';
import { api } from '@/utils/api';

const Gad7: NextPage = () => {
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
      enabled: !!idTest,
      select: (data) =>
        data.administration.records as unknown as { response: FormValues },
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
            General Anxiety Disorder-7 (GAD-7)
          </h1>
        </header>
        <div className="overflow-y-auto pb-8">
          <form className="mx-auto max-w-prose space-y-6">
            <section className="pb-4">
              <header className="sticky top-0 bg-gray-10 pb-3">
                <p className="mb-4 rounded-md bg-white p-4">
                  Nelle <span className="font-bold">ultime 2 settimana</span>,
                  con quale frequenza ti hanno dato fastidio ciascuno dei
                  seguenti problemi?
                </p>
                <p className="font-h3 absolute -right-32 top-80 z-20 rotate-90">
                  (sola visualizzazione)
                </p>
                <ul className="flex items-center justify-end gap-2 pr-4 text-forest-green-700">
                  <li className="w-24 text-center text-sm">Mai</li>
                  <li className="w-24 text-center text-sm">Alcuni giorni</li>
                  <li className="w-24 text-center text-sm">
                    Per oltre la metà dei giorni
                  </li>
                  <li className="w-24 text-center text-sm">
                    Quasi ogni giorno
                  </li>
                </ul>
              </header>
              {QUESTIONS.map((question, index) => (
                <Item
                  key={index}
                  question={question}
                  index={index + 1}
                  defaultValue={response[`item-${index + 1}`]}
                />
              ))}
            </section>
          </form>
        </div>
      </Form>
    </div>
  );
};

export default Gad7;

Gad7.getLayout = (page) => {
  return (
    <RootLayout>
      <PatientLayout>{page}</PatientLayout>
    </RootLayout>
  );
};

import { type NextPage } from 'next';
import { useRouter } from 'next/router';
import { useForm } from 'react-hook-form';

import { Form } from '@/components/ui/form';
import {
  type FormValues,
  PQ16Item,
} from '@/features/questionnaires/pq-16/pq16-item';
import { QUESTIONS } from '@/features/questionnaires/pq-16/pq16-questions';
import { _default as RootLayout, PatientLayout } from '@/layout';
import { type TView } from '@/types/view-types';
import { api } from '@/utils/api';

const PQ16: NextPage = () => {
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
            Questionario dei sintomi prodromici (PQ-16)
          </h1>
          <p className="font-h3 absolute -right-32 top-80 z-20 rotate-90">
            (sola visualizzazione)
          </p>
        </header>
        <div className="overflow-y-auto pb-8">
          <form className="mx-auto max-w-prose space-y-6">
            <section className="pb-4">
              <header className="sticky top-0 bg-gray-10 pb-3">
                <p className="mb-4 rounded-md bg-white p-4">
                  Il questionario esplora aspetti di pensieri, sentimenti ed
                  esperienze. Per ogni affermazione indica se sei d&apos;accordo
                  o in disaccordo, selezionando VERO o FALSO sulla destra. Nel
                  caso tu risponda &quot;vero&quot;, indica nell&apos;ultima
                  colonna il livello di disagio associato (nessuno=0; lieve=1;
                  moderato=2; grave=3).
                </p>
                <div className="flex justify-end">
                  <ul className="mr-12 flex gap-2 text-forest-green-700">
                    <li className="flex w-10 rotate-180 items-center text-sm [writing-mode:vertical-rl]">
                      Vero
                    </li>
                    <li className="flex w-10 rotate-180 items-center text-sm [writing-mode:vertical-rl]">
                      Falso
                    </li>
                  </ul>
                  <ul className="flex gap-2 pr-4 text-forest-green-700">
                    <li className="flex w-10 rotate-180 items-center text-sm [writing-mode:vertical-rl]">
                      Nessuno
                    </li>
                    <li className="flex w-10 rotate-180 items-center text-sm [writing-mode:vertical-rl]">
                      Lieve
                    </li>
                    <li className="flex w-10 rotate-180 items-center text-sm [writing-mode:vertical-rl]">
                      Moderato
                    </li>
                    <li className="flex w-10 rotate-180 items-center text-sm [writing-mode:vertical-rl]">
                      Grave
                    </li>
                  </ul>
                </div>
              </header>
              {QUESTIONS.map((question) => {
                return (
                  <PQ16Item
                    key={question.index}
                    question={question.text}
                    index={question.index}
                    defaultValue={response?.[`item-${question.index}`]?.value}
                    defaultScore={response?.[`item-${question.index}`]?.score}
                  />
                );
              })}
            </section>
          </form>
        </div>
      </Form>
    </div>
  );
};

export default PQ16;

PQ16.getLayout = (page) => {
  return (
    <RootLayout>
      <PatientLayout>{page}</PatientLayout>
    </RootLayout>
  );
};

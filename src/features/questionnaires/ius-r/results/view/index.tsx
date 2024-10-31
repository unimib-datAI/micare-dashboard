import { type NextPage } from 'next';
import { useRouter } from 'next/router';
import { useForm } from 'react-hook-form';

import { Form } from '@/components/ui/form';
import { type FormValues, Item } from '@/features/questionnaires/ius-r/item';
import { QUESTIONS } from '@/features/questionnaires/ius-r/questions';
import { _default as RootLayout, PatientLayout } from '@/layout';
import { type TView } from '@/types/view-types';
import { api } from '@/utils/api';

const IusR: NextPage = () => {
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
      select: (data) => data.administration.records as unknown as FormValues,
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
            Intolerance of Uncertainty Scale-Revised (IUS-R)
          </h1>
        </header>
        <div className="overflow-y-auto pb-8">
          <form className="mx-auto max-w-prose space-y-6">
            <section className="pb-4">
              <header className="sticky top-0 bg-gray-10 pb-3">
                <p className="mb-4 rounded-md bg-white p-4">
                  Di seguito troverà una serie di affermazioni. La preghiamo di
                  leggere attentamente ciascuna affermazione e di indicare
                  quella che meglio la descrive.
                </p>
                <p className="font-h3 absolute -right-32 top-80 z-20 rotate-90">
                  (sola visualizzazione)
                </p>
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
              </header>
              {QUESTIONS.map((question, index) => (
                <Item key={index} question={question} defaultValue={response} />
              ))}
            </section>
          </form>
        </div>
      </Form>
    </div>
  );
};

export default IusR;

IusR.getLayout = (page) => {
  return (
    <RootLayout>
      <PatientLayout>{page}</PatientLayout>
    </RootLayout>
  );
};

import { CircleHelp } from 'lucide-react';
import { type NextPage } from 'next';
import { useRouter } from 'next/router';
import { useForm } from 'react-hook-form';

import { Dialog, DialogContent, DialogTrigger } from '@/components/ui/dialog';
import { Form } from '@/components/ui/form';
import { type FormValues, Item } from '@/features/questionnaires/pdss/item';
import { QUESTIONS } from '@/features/questionnaires/pdss/questions';
import { _default as RootLayout, PatientLayout } from '@/layout';
import { type TView } from '@/types/view-types';
import { api } from '@/utils/api';

const Pdss: NextPage = () => {
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
            Panic Disorder Severity Scale (PDSS)
          </h1>
        </header>
        <div className="overflow-y-auto pb-8">
          <form className="mx-auto max-w-prose space-y-6">
            <section className="pb-4">
              <Dialog>
                <DialogTrigger className="sticky top-0 z-10 mb-4 bg-gray-10 pb-4">
                  <header className="z-10 rounded-md bg-white p-4">
                    <p className="flex items-center">
                      Istruzioni{' '}
                      <CircleHelp className="ml-2 h-4 w-4 text-forest-green-700" />
                    </p>
                    <p className="text-left text-sm font-bold">
                      Per ognuna delle seguenti domande, rispondi indicando una
                      fra le alternative che meglio descrive la tua esperienza.
                    </p>
                  </header>
                  <p className="font-h3 absolute -right-32 top-80 z-20 rotate-90">
                    (sola visualizzazione)
                  </p>
                </DialogTrigger>
                <DialogContent className="max-w-prose">
                  <p className="font-bold">Istruzioni</p>
                  <p>
                    Nel questionario che segue si utilizza la definizione di
                    attacco di panico come un&apos;improvvisa ondata di paura o
                    disagio accompagnata da almeno quattro dei sintomi
                    &ldquo;ondata improvvisa&rdquo; è necessario che i sintomi
                    raggiungano il loro massimo nei primi dieci minuti. Di
                    seguito si trovano elencati i sintomi da prendere in
                    considerazione:
                  </p>
                  <ul className="ml-4 list-disc">
                    <li>
                      battito cardiaco accelerato o martellante dolore o
                      fastidio al petto
                    </li>
                    <li>brividi o vampate di calore tremori</li>
                    <li>sudore</li>
                    <li>nausea</li>
                    <li>paura di perdere il controllo o di impazzire</li>
                    <li>vertigini o debolezza</li>
                    <li>affanno allucinazioni</li>
                    <li>senso di soffocamento</li>
                    <li>formicolio</li>
                  </ul>
                </DialogContent>
              </Dialog>
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

export default Pdss;

Pdss.getLayout = (page) => {
  return (
    <RootLayout>
      <PatientLayout>{page}</PatientLayout>
    </RootLayout>
  );
};

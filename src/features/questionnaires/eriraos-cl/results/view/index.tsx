import { HelpCircle } from 'lucide-react';
import { type NextPage } from 'next';
import { useRouter } from 'next/router';
import { useContext, useState } from 'react';
import { useForm } from 'react-hook-form';

import { Form } from '@/components/ui/form';
import { Label } from '@/components/ui/label';
import { Separator } from '@/components/ui/separator';
import { Switch } from '@/components/ui/switch';
import { RootContainerRefContext } from '@/context';
import { Dialog } from '@/features/questionnaires/eriraos-cl/instructions-dialog';
import { ItemStepOne } from '@/features/questionnaires/eriraos-cl/item-step-one';
import { ItemStepTwo } from '@/features/questionnaires/eriraos-cl/item-step-two';
import { QUESTIONS } from '@/features/questionnaires/eriraos-cl/questions';
import { type FormValues } from '@/features/questionnaires/eriraos-cl/schema';
import { _default as RootLayout, PatientLayout } from '@/layout';
import { type TView } from '@/types/view-types';
import { api } from '@/utils/api';

const PQ16: NextPage = () => {
  const { query } = useRouter();
  const { view } = query;
  const [_, idTest] = view as TView;

  const containerRef = useContext(RootContainerRefContext);

  const [expand, setExpand] = useState<{ [key: string]: boolean }>({
    'item-1': false,
    'item-2': false,
    'item-3': false,
    'item-4': false,
    'item-5': false,
    'item-6': false,
    'item-7': false,
    'item-8': false,
    'item-9': false,
    'item-10': false,
    'item-11': false,
    'item-12': false,
    'item-13': false,
    'item-14': false,
    'item-15': false,
    'item-16': false,
    'item-17': false,
  });

  const isAllExpanded = Object.values(expand).every((value) => value);

  const setExpandAll = () => {
    setExpand((prev) =>
      Object.fromEntries(
        Object.keys(prev).map((key) => [key, isAllExpanded ? false : true])
      )
    );
  };

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

  console.log({ response });

  const QUETIONS_ONE = QUESTIONS.slice(0, 12);
  const QUETIONS_TWO = QUESTIONS.slice(13);

  return (
    <div className="grid h-[calc(100dvh_-_theme(spacing.6)_-_theme(spacing.32))] grid-rows-[auto_1fr_auto]">
      <Form {...form}>
        <header className="sticky top-32 mx-auto max-w-prose pb-3">
          <h1 className="font-h1 leading-tight">
            Early Recognition Inventory for the retrospective assessment of the
            onset of schizophrenia Checklist (ERIraos-CL)
          </h1>
        </header>
        <div className="overflow-y-auto pb-8">
          <form className="mx-auto max-w-prose space-y-6">
            <section className="relative pb-4">
              <header className="sticky top-0 bg-gray-10">
                <Dialog
                  className="max-w-prose"
                  containerRef={containerRef}
                  trigger={
                    <div className="flex w-full cursor-pointer items-center rounded-md bg-white p-4 text-sm">
                      <HelpCircle className="mr-1 h-4 w-4 text-forest-green-700" />{' '}
                      Istruzioni per l&apos;intervista
                    </div>
                  }
                >
                  La presente intervista può aiutare a valutare se una persona
                  ha provato alcune esperienze particolari nel corso degli
                  ultimi sei mesi. Le risposte alle domande dell&apos;intervista
                  potranno permettere di identificare i segnali precoci di
                  disturbo mentale.
                  <ul className="list-disc pl-5 text-sm">
                    <li>
                      Se la persona conferma senza alcun dubbio la presenza di
                      un sintomo nel periodo considerato, barrate la casella
                      intestata SI.
                    </li>
                    <li>
                      Se la persona nega chiaramente la presenza di un sintomo,
                      barrate la casella intestata NO.{' '}
                    </li>
                    <li>
                      Nel caso in cui non riusciste ad accertare in modo chiaro
                      l&apos;eventuale presenza di un sintomo con le domande
                      poste, oppure vi sentiste incerti riguardo alla
                      valutazione di un sintomo, utilizzate l&apos;opzione
                      &quot;?&quot;.
                    </li>
                  </ul>
                </Dialog>
                <p className="font-h3 absolute -right-28 top-80 z-20 rotate-90">
                  (sola visualizzazione)
                </p>
              </header>
              <div className="sticky top-[52px] flex justify-between bg-gray-10 py-4">
                <span className="self-center text-sm">Negli ultimi 6 mesi</span>
                <div className="flex">
                  <ul className="flex gap-2 text-forest-green-700">
                    <li className="flex w-10 items-center justify-center text-sm">
                      Sì
                    </li>
                    <li className="flex w-10 items-center justify-center text-sm">
                      No
                    </li>
                    <li className="flex w-10 items-center justify-center text-sm">
                      ?
                    </li>
                  </ul>
                  <Separator orientation="vertical" className="mx-4 " />
                  <div className="flex flex-col items-center space-y-2">
                    <Label htmlFor="expand-all-one">Espandi tutto</Label>
                    <Switch
                      id="expand-all-one"
                      checked={isAllExpanded}
                      onCheckedChange={setExpandAll}
                    />
                  </div>
                </div>
              </div>
              {QUETIONS_ONE.map((question) => {
                return (
                  <ItemStepOne
                    key={question.index}
                    question={question}
                    expanded={expand[`item-${question.index}`] ?? false}
                    setExpand={setExpand}
                    defaultValue={
                      response.items[`item-${question.index}`]?.value
                    }
                    defaultNote={response.items[`item-${question.index}`]?.note}
                  />
                );
              })}
              <div className="sticky top-[52px] flex justify-between bg-gray-10 py-4">
                <span className="self-center text-sm">
                  In qualche momento della vita
                </span>
                <div className="flex">
                  <ul className="flex gap-2 text-forest-green-700">
                    <li className="flex w-10 items-center justify-center text-sm">
                      Sì
                    </li>
                    <li className="flex w-10 items-center justify-center text-sm">
                      No
                    </li>
                    <li className="flex w-10 items-center justify-center text-sm">
                      ?
                    </li>
                  </ul>
                  <Separator orientation="vertical" className="mx-4 " />
                  <div className="flex flex-col items-center space-y-2">
                    <Label htmlFor="expand-all-two">Espandi tutto</Label>
                    <Switch
                      id="expand-all-two"
                      checked={isAllExpanded}
                      onCheckedChange={setExpandAll}
                    />
                  </div>
                </div>
              </div>
              {QUETIONS_TWO.map((question) => {
                return (
                  <ItemStepOne
                    key={question.index}
                    question={question}
                    expanded={expand[`item-${question.index}`] ?? false}
                    setExpand={setExpand}
                    defaultValue={
                      response.items[`item-${question.index}`]?.value
                    }
                    defaultNote={response.items[`item-${question.index}`]?.note}
                  />
                );
              })}
            </section>
            <section className="relative pb-4">
              <header className="sticky top-0 flex w-full rounded-md bg-white p-4 text-sm">
                Domande da porre alla fine dell&apos;intervista sui sintomi 1-17
              </header>
              <ItemStepTwo defaultValue={response.post} />
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

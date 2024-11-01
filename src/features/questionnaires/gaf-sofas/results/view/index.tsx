import { type NextPage } from 'next';
import { useRouter } from 'next/router';
import { useForm } from 'react-hook-form';

import {
  Form,
  FormControl,
  FormField,
  FormItem,
  FormLabel,
} from '@/components/ui/form';
import { Slider } from '@/components/ui/slider';
import { type FormValues } from '@/features/questionnaires/gaf-sofas/item';
import { Item } from '@/features/questionnaires/gaf-sofas/item';
import { _default as RootLayout, PatientLayout } from '@/layout';
import { type TView } from '@/types/view-types';
import { api } from '@/utils/api';
import { cn } from '@/utils/cn';

const TICKS = Array.from({ length: 101 }, (_, i) => i);

const GafSofas: NextPage = () => {
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
            Scala per la Valutazione Globale del Funzionamento (VGF)
          </h1>
        </header>
        <div className="overflow-y-auto pb-8">
          <form className="mx-auto max-w-prose space-y-6">
            <section className="pb-4">
              <header className="sticky top-0 z-10 bg-gray-10 pb-3 ">
                <p className="mb-4 rounded-md bg-white p-4">
                  Considerare il funzionamento psicologico, sociale e lavorativo
                  nell&apos;ambito di un ipotetico continuum salute-malattia
                  mentale. Non includere le menomazioni del funzionamento dovute
                  a limitazioni fisiche (o ambientali).{' '}
                  <span className="text-sm">
                    Nota: usare codici intermedi, ove necessario, per es. 45,
                    68, 72. .
                  </span>
                </p>
                <p className="font-h3 absolute -right-28 top-80 z-20 rotate-90">
                  (sola visualizzazione)
                </p>
                <FormField
                  control={form.control}
                  defaultValue={response.value}
                  name="value"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel className="text-sm text-forest-green-700">
                        Codice
                      </FormLabel>
                      <FormControl>
                        <div className="relative pb-5 pt-12">
                          <div className="absolute flex h-12 w-full -translate-y-5 items-center justify-between px-4">
                            {TICKS.map((tick) => (
                              <div
                                key={tick}
                                className={cn(
                                  'relative h-10 w-px bg-space-gray',
                                  tick % 10 === 0 ? 'h-12 ' : 'h-6'
                                )}
                              >
                                {tick % 10 === 0 && (
                                  <span className="absolute -translate-x-1/2 -translate-y-full">
                                    {tick}
                                  </span>
                                )}
                              </div>
                            ))}
                          </div>
                          <Slider
                            value={field.value}
                            onValueChange={field.onChange}
                            max={100}
                            step={1}
                            disabled
                            className="rounded-full"
                            thumbClassName="h-8 w-8 grid place-items-center border-4 border-forest-green-700 text-forest-green-700"
                          >
                            <span className="text-sm font-bold">
                              {field.value[0]}
                            </span>
                          </Slider>
                        </div>
                      </FormControl>
                    </FormItem>
                  )}
                />
              </header>
              <Item value={response.value} />
            </section>
          </form>
        </div>
      </Form>
    </div>
  );
};

export default GafSofas;

GafSofas.getLayout = (page) => {
  return (
    <RootLayout>
      <PatientLayout>{page}</PatientLayout>
    </RootLayout>
  );
};

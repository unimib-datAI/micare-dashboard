import { zodResolver } from '@hookform/resolvers/zod';
import { useForm } from 'react-hook-form';

import {
  FormControl,
  FormField,
  FormItem,
  FormLabel,
} from '@/components/ui/form';
import { Slider } from '@/components/ui/slider';
import {
  FormContent,
  FormFooter,
  FormHeader,
  FormInstructions,
  FormSubmit,
} from '@/features/questionnaires/components/form';
import {
  formSchema,
  type FormValues,
  Item,
} from '@/features/questionnaires/gaf-sofas/item';
import { useAdministration } from '@/features/questionnaires/hooks/use-administration-submit';
import { cn } from '@/utils/cn';

const TICKS = Array.from({ length: 101 }, (_, i) => i);

const GafSofas = () => {
  const form = useForm<FormValues>({
    resolver: zodResolver(formSchema),
    defaultValues: {
      value: [50],
    },
  });
  const value = form.watch('value');

  const formatRecords = (data: FormValues) => {
    return {
      response: data,
    };
  };

  const { onSubmit } = useAdministration<FormValues>({
    formatRecords,
    type: 'gaf-sofas',
  });

  return (
    <FormContent<FormValues>
      form={form}
      title="Scala per la Valutazione Globale del Funzionamento (VGF)"
    >
      <FormHeader>
        <FormInstructions>
          <p>
            Considerare il funzionamento psicologico, sociale e lavorativo
            nell&apos;ambito di un ipotetico continuum salute-malattia mentale.
            Non includere le menomazioni del funzionamento dovute a limitazioni
            fisiche (o ambientali).
          </p>
          <small>
            Nota: usare codici intermedi, ove necessario, per es. 45, 68, 72. .
          </small>
        </FormInstructions>
        <FormField
          control={form.control}
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
                    className="rounded-full"
                    thumbClassName="h-8 w-8 grid place-items-center border-4 border-forest-green-700 cursor-grab active:cursor-grabbing text-forest-green-700"
                  >
                    <span className="text-sm font-bold">{field.value[0]}</span>
                  </Slider>
                </div>
              </FormControl>
            </FormItem>
          )}
        />
      </FormHeader>
      <Item value={value} />
      <FormFooter type="gaf-sofas" className="justify-end">
        <FormSubmit form={form} onSubmit={onSubmit} />
      </FormFooter>
    </FormContent>
  );
};

export default GafSofas;

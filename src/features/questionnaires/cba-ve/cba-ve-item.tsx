import { useFormContext } from 'react-hook-form';
import { z } from 'zod';

import {
  FormControl,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from '@/components/ui/form';
import { RadioGroup, RadioGroupItem } from '@/components/ui/radio-group';
import { cn } from '@/utils/cn';

type Props = {
  question: string;
  index: number;
  defaultValue?: string;
};

export const formSchema = z.record(
  z.string(),
  z
    .string({
      required_error:
        'Attenzione! Devi selezionare una risposta per poter caricare la somministrazione',
    })
    .min(1, {
      message:
        'Attenzione! Devi selezionare una risposta per poter caricare la somministrazione',
    })
);
export type FormValues = z.infer<typeof formSchema>;

export const CbaVeItem = (props: Props) => {
  const { question, index, defaultValue } = props;

  const form = useFormContext<FormValues>();

  return (
    <FormField
      control={form.control}
      name={`item-${index}`}
      defaultValue={defaultValue ?? ''}
      render={({ field }) => {
        return (
          <div
            className={cn(
              'mb-2 flex flex-col rounded-md border border-white bg-white p-4 transition-colors duration-300',
              field.value && ' border-slate-200 bg-gray-10'
            )}
          >
            <FormItem className="flex w-full items-center space-y-0">
              <FormLabel>
                <div className="grid grid-cols-[auto,1fr] gap-2">
                  <span className="text-slate-500">{index}.</span>
                  <span className="text-space-gray">{`${question}`}</span>
                </div>
              </FormLabel>
              <FormControl>
                <RadioGroup
                  disabled={!!defaultValue}
                  orientation="horizontal"
                  onValueChange={field.onChange}
                  defaultValue={field.value}
                  className="ml-auto mt-0 shrink-0 grid-cols-5"
                >
                  {Array.from(Array(5).keys()).map((i) => {
                    return (
                      <FormItem
                        key={i.toString()}
                        className="flex w-20 items-center justify-center space-x-3 text-forest-green-400"
                      >
                        <FormControl>
                          <RadioGroupItem
                            value={i.toString()}
                            className="border-forest-green-700 disabled:opacity-100"
                          />
                        </FormControl>
                      </FormItem>
                    );
                  })}
                </RadioGroup>
              </FormControl>
            </FormItem>
            <FormMessage className="-mb-2 mt-2" />
          </div>
        );
      }}
    />
  );
};

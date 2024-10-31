import { useFormContext, useWatch } from 'react-hook-form';
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
  defaultScore?: string;
};

export const formSchema = z.record(
  z.string(),
  z.object({
    value: z.string({
      required_error:
        'Attenzione! Devi selezionare una risposta per poter caricare la somministrazione',
    }),
    score: z.string().optional(),
  })
);
export type FormValues = z.infer<typeof formSchema>;

export const PQ16Item = (props: Props) => {
  const { question, index, defaultValue, defaultScore } = props;

  const form = useFormContext<FormValues>();

  const questionValue = useWatch({
    control: form.control,
    name: `item-${index}.value`,
  });

  return (
    <div className="mb-2 grid grid-cols-[1fr,auto]">
      <div className="mr-4 grid grid-cols-[1fr,auto] rounded-md border border-white bg-white p-4 transition-colors duration-300">
        <FormLabel>
          <div className="grid grid-cols-[auto,1fr] gap-2">
            <span className="text-slate-500">{index}.</span>
            <span className="text-space-gray">{`${question}`}</span>
          </div>
        </FormLabel>
        <FormField
          control={form.control}
          defaultValue={defaultValue ?? ''}
          name={`item-${index}.value`}
          render={({ field }) => {
            const handleOnChange = (value: string) => {
              field.onChange(value);
              form.setValue(`item-${index}.score`, '0', { shouldDirty: true });
            };
            return (
              <FormItem className="flex items-center justify-end space-y-0">
                <FormControl>
                  <RadioGroup
                    disabled={!!defaultValue}
                    orientation="horizontal"
                    onValueChange={handleOnChange}
                    defaultValue={field.value}
                    className="mt-0 flex shrink-0"
                  >
                    <FormItem className="flex w-10 items-center justify-center space-x-3 text-forest-green-400">
                      <FormControl>
                        <RadioGroupItem
                          value="true"
                          className="border-forest-green-700 disabled:opacity-100"
                        />
                      </FormControl>
                    </FormItem>
                    <FormItem className="flex w-10 items-center justify-center space-x-3 text-forest-green-400">
                      <FormControl>
                        <RadioGroupItem
                          value="false"
                          className="border-forest-green-700 disabled:opacity-100"
                        />
                      </FormControl>
                    </FormItem>
                  </RadioGroup>
                </FormControl>
              </FormItem>
            );
          }}
        />
      </div>
      <div className="flex items-stretch">
        <FormField
          control={form.control}
          defaultValue={defaultScore ?? ''}
          name={`item-${index}.score`}
          render={({ field }) => {
            return (
              <FormItem className="flex items-stretch space-y-0">
                <FormControl>
                  <RadioGroup
                    disabled={!!defaultScore}
                    orientation="horizontal"
                    onValueChange={field.onChange}
                    defaultValue="0"
                    value={questionValue === 'false' ? '0' : field.value}
                    className={cn(
                      'mt-0 flex shrink-0 rounded-md border border-white bg-white p-4 transition-colors duration-300',
                      questionValue === 'false' &&
                        'cursor-not-allowed border-slate-200 bg-gray-10'
                    )}
                  >
                    {Array.from(Array(4).keys()).map((i) => {
                      return (
                        <FormItem
                          key={i.toString()}
                          className={cn(
                            'flex w-10 items-center justify-center space-x-3 text-forest-green-400',
                            questionValue === 'false' && 'pointer-events-none'
                          )}
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
            );
          }}
        />
      </div>
      <FormMessage className="-mb-2 mt-2" />
    </div>
  );
};

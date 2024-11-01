import { useRef } from 'react';
import { z } from 'zod';

import { cn } from '@/utils/cn';

import { QUESTIONS } from './questions';

export const formSchema = z.object({
  value: z.array(z.number().min(0).max(100)),
});

export type FormValues = z.infer<typeof formSchema>;

type Props = {
  value: number[];
};

export const Item = (props: Props) => {
  const { value } = props;
  const selectedValue = value[0] ?? 0;

  const cardRef = useRef<Map<number, HTMLElement>>(new Map());

  const isCardSelected = (item: (typeof QUESTIONS)[number], index: number) => {
    const idSelected = selectedValue >= item.min && selectedValue <= item.max;

    if (idSelected && cardRef.current.has(index)) {
      cardRef.current.get(index)?.scrollIntoView({
        block: 'center',
        behavior: 'smooth',
      });
    }

    return idSelected;
  };

  return (
    <div className="w-full space-y-4">
      {QUESTIONS.map((item, index) => (
        <div
          key={index}
          ref={(ref) => void cardRef.current.set(index, ref as HTMLElement)}
          className={cn(
            'rounded-md bg-card p-4',
            isCardSelected(item, index) &&
              'outline -outline-offset-4 outline-forest-green-700'
          )}
        >
          <p className="font-bold">
            {item.min === 0 ? 0 : `${item.min} - ${item.max}`}
          </p>
          <p>{item.text}</p>
        </div>
      ))}
    </div>
  );
};

import { Fragment } from 'react';

import { Separator } from '@/components/ui/separator';
import { QUESTIONS } from '@/features/questionnaires/ius-r/questions';

const RESPONSES_DICT = {
  1: "Per niente d'accordo",
  2: "Un po' d'accordo",
  3: "Moderatamente d'accordo",
  4: "Molto d'accordo",
  5: "Completamente d'accordo",
} as const;

type Props = {
  responses: Record<string, string>;
};

export const DetailsList = (props: Props) => {
  const { responses } = props;

  const items = Object.entries(responses).map(([index, response]) => {
    return [
      +index.split('-')[1] - 1,
      parseInt(response) as 1 | 2 | 3 | 4 | 5,
    ] as const;
  });

  return (
    <div className="-mb-px grid grid-cols-[1fr,auto,auto] items-center">
      <p className="p-4 font-bold">Elenco item</p>
      <Separator orientation="vertical" className="mx-4" />
      <p className="pr-4 font-bold">Risposte</p>
      <Separator className="col-span-3" />
      {items.map(([index, response]) => (
        <Fragment key={index}>
          <div className="grid h-14 grid-cols-[auto,1fr] items-center gap-2 pl-4 text-sm">
            <span className="text-forest-green-700">
              {QUESTIONS[index]?.id}
            </span>
            <span>{QUESTIONS[index]?.text}</span>
          </div>

          <Separator orientation="vertical" className="mx-4" />

          <div className="flex w-36 items-center justify-start pr-4 text-sm">
            {RESPONSES_DICT[response]}
          </div>

          <Separator className="col-span-3 last:hidden" />
        </Fragment>
      ))}
    </div>
  );
};

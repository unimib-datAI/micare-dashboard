import { Fragment } from 'react';

import { Separator } from '@/components/ui/separator';
import { QUESTIONS } from '@/features/questionnaires/gad-7/questions';

const RESPONSES_DICT = {
  0: 'Mai',
  1: 'Alcuni giorni',
  2: 'Per oltre la metà dei giorni',
  3: 'Quasi ogni giorno',
} as const;

type Props = {
  responses: Record<string, string>;
};

export const DetailsList = (props: Props) => {
  const { responses } = props;

  const items = Object.entries(responses).map(([_, response], index) => {
    return [index, parseInt(response) as 0 | 1 | 2 | 3] as const;
  });

  return (
    <div className="-mb-px grid grid-cols-[1fr,auto,auto] items-center">
      <p className="p-4 font-bold">Elenco item</p>
      <Separator orientation="vertical" className="mx-4" />
      <p className="pr-4 font-bold">Risposte</p>
      <Separator className="col-span-3" />
      {items.map(([index, response]) => (
        <Fragment key={index}>
          <div className="grid h-14 grid-cols-[auto,1fr] items-center gap-2 pl-4">
            <span className="text-forest-green-700">{index + 1}.</span>
            <span>{QUESTIONS[index]}</span>
          </div>

          <Separator orientation="vertical" className="mx-4" />

          <div className="flex w-36 items-center justify-start pr-4">
            {RESPONSES_DICT[response]}
          </div>

          <Separator className="col-span-3 last:hidden" />
        </Fragment>
      ))}
    </div>
  );
};

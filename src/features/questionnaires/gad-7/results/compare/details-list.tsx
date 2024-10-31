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
  prevResponses: Record<string, string>;
  nextResponses: Record<string, string>;
  prevT: number;
  nextT: number;
};

export const DetailsList = (props: Props) => {
  const { prevResponses, nextResponses, prevT, nextT } = props;

  const prevItems = Object.entries(prevResponses).map(
    ([_, response], index) => {
      return [index, parseInt(response) as 0 | 1 | 2 | 3] as const;
    }
  );

  const nextItems = Object.entries(nextResponses).map(
    ([_, response], index) => {
      return [index, parseInt(response) as 0 | 1 | 2 | 3] as const;
    }
  );

  return (
    <div className="-mb-px grid grid-cols-[1fr,auto,auto,auto,auto] items-center">
      <p className="p-4 font-bold">Elenco item</p>
      <Separator orientation="vertical" className="mx-4" />
      <p className="font-bold">Risposte T{prevT}</p>
      <Separator orientation="vertical" className="mx-4" />
      <p className="pr-4 font-bold">Rispsote T{nextT}</p>
      <Separator className="col-span-5" />

      {prevItems.map(([index, response]) => {
        const nextResponse = nextItems?.[index]?.[1];
        if (!nextResponse) return null;

        return (
          <Fragment key={index}>
            <div className="grid h-14 grid-cols-[auto,1fr] items-center gap-2 pl-4">
              <span className="text-forest-green-700">{index + 1}.</span>
              <span>{QUESTIONS[index]}</span>
            </div>

            <Separator orientation="vertical" className="mx-4" />
            <div className="flex w-36 items-center justify-start pr-4">
              {RESPONSES_DICT[response]}
            </div>

            <Separator orientation="vertical" className="mx-4" />
            <div className="flex w-36 items-center justify-start pr-4">
              {RESPONSES_DICT[nextResponse]}
            </div>

            <Separator className="col-span-5 last:hidden" />
          </Fragment>
        );
      })}
    </div>
  );
};

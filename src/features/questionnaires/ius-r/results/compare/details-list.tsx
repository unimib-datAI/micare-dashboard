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
  prevResponse: Record<string, string>;
  nextResponse: Record<string, string>;
  prevT: number;
  nextT: number;
};

export const DetailsList = (props: Props) => {
  const { prevResponse, nextResponse, prevT, nextT } = props;

  const prevItems = Object.entries(prevResponse).map(([index, response]) => {
    return [
      +index.split('-')[1] - 1,
      parseInt(response) as 1 | 2 | 3 | 4 | 5,
    ] as const;
  });

  const nextItems = Object.entries(nextResponse).map(([index, response]) => {
    return [
      +index.split('-')[1] - 1,
      parseInt(response) as 1 | 2 | 3 | 4 | 5,
    ] as const;
  });

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
            <div className="grid h-14 grid-cols-[auto,1fr] items-center gap-2 pl-4 text-sm">
              <span className="text-forest-green-700">
                {QUESTIONS[index]?.id}
              </span>
              <span>{QUESTIONS[index]?.text}</span>
            </div>

            <Separator orientation="vertical" className="mx-4" />
            <div className="flex w-24 items-center justify-start pr-4 text-sm">
              {RESPONSES_DICT[response]}
            </div>

            <Separator orientation="vertical" className="mx-4" />
            <div className="flex w-24 items-center justify-start pr-4 text-sm">
              {RESPONSES_DICT[nextResponse]}
            </div>

            <Separator className="col-span-5 last:hidden" />
          </Fragment>
        );
      })}
    </div>
  );
};

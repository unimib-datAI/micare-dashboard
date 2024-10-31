import { type FormValues } from '@/features/questionnaires/gaf-sofas/item';
import { QUESTIONS } from '@/features/questionnaires/gaf-sofas/questions';

type Props = {
  prevResponse: FormValues;
  nextResponse: FormValues;
  prevT: number;
  nextT: number;
};

export const Details = (props: Props) => {
  const { prevResponse, nextResponse, prevT, nextT } = props;

  const prevScore = prevResponse.value[0];
  const nextScore = nextResponse.value[0];

  if (!prevScore || !nextScore) return null;

  const prevItem = QUESTIONS.find(
    (item) => item.min <= prevScore && item.max >= prevScore
  );
  const nextItem = QUESTIONS.find(
    (item) => item.min <= nextScore && item.max >= nextScore
  );

  if (!prevItem || !nextItem) return null;

  return (
    <div className="mt-4 grid grid-cols-[auto,1fr] place-items-start gap-4">
      <span className="w-12 text-forest-green-700">T{prevT}</span>
      <div className="rounded-md border border-forest-green-700 bg-card p-4">
        <p className="font-bold">
          {prevItem.min === 0 ? 0 : `${prevItem.min} - ${prevItem.max}`}
        </p>
        <p>{prevItem.text}</p>
      </div>

      <span className="text-forest-green-700">T{nextT}</span>
      <div className="rounded-md border border-forest-green-700 bg-card p-4">
        <p className="font-bold">
          {nextItem.min === 0 ? 0 : `${nextItem.min} - ${nextItem.max}`}
        </p>
        <p>{nextItem.text}</p>
      </div>
    </div>
  );
};

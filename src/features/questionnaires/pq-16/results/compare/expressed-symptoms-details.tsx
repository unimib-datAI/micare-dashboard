import { type FormValues } from '@/features/questionnaires/pq-16/pq16-item';
import { QUESTIONS } from '@/features/questionnaires/pq-16/pq16-questions';

type Props = {
  prevResponse: FormValues;
  nextResponse: FormValues;
};

export const ExpressedSymptomsDetails = (props: Props) => {
  const { prevResponse, nextResponse } = props;

  const expressedSymptoms = Object.entries(prevResponse)
    .map(([index, record]) => {
      return {
        index,
        prevRecord: record,
        nextRecord: nextResponse[index] ?? { value: 'false' },
      };
    })
    .filter(
      ({ prevRecord, nextRecord }) =>
        prevRecord.value === 'true' || nextRecord.value === 'true'
    );

  return expressedSymptoms.map((item) => {
    const { index, prevRecord, nextRecord } = item;
    const id = parseInt(index.split('-')[1]);
    if (!id) return null;

    const getValue = (value: string) => {
      return value === 'true' ? 'V' : 'F';
    };
    return (
      <div
        className="-mb-px grid grid-cols-[58rem,4rem,4rem] border border-slate-300 p-2 pr-0"
        key={index}
      >
        <div className="grid grid-cols-[auto,1fr] gap-2">
          <span className="text-forest-green-700">{QUESTIONS[id]?.index}.</span>
          <span>{QUESTIONS[id]?.text}</span>
        </div>

        <span className="text-md border-l border-slate-300 text-center">
          {getValue(prevRecord.value)}
        </span>
        <span className="text-md border-l border-slate-300 text-center">
          {getValue(nextRecord.value)}
        </span>
      </div>
    );
  });
};

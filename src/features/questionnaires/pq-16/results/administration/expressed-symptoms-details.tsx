import { QUESTIONS } from '@/features/questionnaires/pq-16/pq16-questions';

type Props = {
  expressedSymptoms: [string, { value: string; score?: string | undefined }][];
};

export const ExpressedSymptomsDetails = (props: Props) => {
  const { expressedSymptoms } = props;

  return expressedSymptoms.map(([index]) => {
    const id = parseInt(index.split('-')[1]);
    if (!id) return null;
    return (
      <div className="mb-2 grid grid-cols-[1fr,auto]" key={index}>
        <div className="grid grid-cols-[auto,1fr] gap-2">
          <span className="text-forest-green-700">{QUESTIONS[id]?.index}.</span>
          <span>{QUESTIONS[id]?.text}</span>
        </div>
        <div className="flex items-stretch">
          <div className="flex items-center justify-end space-y-0">
            <div className="flex w-10 items-center justify-center space-x-3 text-forest-green-400">
              <div className="border-forest-green-700 disabled:opacity-100"></div>
            </div>
          </div>
        </div>
      </div>
    );
  });
};

import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { cn } from '@/utils/cn';

type Props = {
  prevExpressedSymptomsCount: number;
  prevExpressedSymptomsScore: number;
  nextExpressedSymptomsCount: number;
  nextExpressedSymptomsScore: number;
};

export const ComparisonCards = (props: Props) => {
  const {
    prevExpressedSymptomsCount,
    prevExpressedSymptomsScore,
    nextExpressedSymptomsCount,
    nextExpressedSymptomsScore,
  } = props;
  const administrationCountDifference =
    nextExpressedSymptomsCount - prevExpressedSymptomsCount;
  const administrationScoreDifference =
    nextExpressedSymptomsScore - prevExpressedSymptomsScore;

  const getDifferenceBgColor = (difference: number) => {
    if (difference > 0) return 'bg-red-400';
    if (difference < 0) return 'bg-emerald-500';
    return 'bg-yellow-400';
  };

  const getDifferenceScore = (difference: number) => {
    if (difference > 0) return `+${difference}`;
    return difference;
  };

  const getDifferenceText = (difference: number, singular: boolean) => {
    if (difference > 0) return `peggiorat${singular ? 'o' : 'i'}`;
    return `migliorat${singular ? 'o' : 'i'}`;
  };

  return (
    <div className="flex gap-2">
      <Card className="relative flex h-full w-48 flex-col items-center transition-all duration-300">
        <CardHeader className="space-y-0 p-4 pb-0">
          <CardTitle className="pr-1 text-center text-base font-normal">
            I sintomi sono{' '}
            <span className="font-semibold">
              {getDifferenceText(administrationCountDifference, false)}
            </span>
          </CardTitle>
        </CardHeader>
        <CardContent className="p-4">
          <div
            className={cn(
              'flex h-16 w-16 items-center justify-center self-center rounded-full p-4',
              getDifferenceBgColor(administrationCountDifference)
            )}
          >
            <span
              className={cn(
                'relative text-lg font-bold text-white',
                getDifferenceScore(administrationCountDifference) !== 0 &&
                  '-left-1'
              )}
            >
              {getDifferenceScore(administrationCountDifference)}
            </span>
          </div>
        </CardContent>
      </Card>

      <Card className="relative flex h-full w-48 flex-col items-center transition-all duration-300">
        <CardHeader className="space-y-0 p-4 pb-0">
          <CardTitle className="pr-1 text-center text-base font-normal">
            Il distress è{' '}
            <span className="font-semibold">
              {getDifferenceText(administrationScoreDifference, true)}
            </span>
          </CardTitle>
        </CardHeader>
        <CardContent className="p-4">
          <div
            className={cn(
              'flex h-16 w-16 items-center justify-center self-center rounded-full p-4',
              getDifferenceBgColor(administrationScoreDifference)
            )}
          >
            <span
              className={cn(
                'relative text-lg font-bold text-white',
                getDifferenceScore(administrationScoreDifference) !== 0 &&
                  '-left-1'
              )}
            >
              {getDifferenceScore(administrationScoreDifference)}
            </span>
          </div>
        </CardContent>
      </Card>
    </div>
  );
};

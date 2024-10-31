import { cn } from '@/utils/cn';

type Props = {
  label: 'IU Prospettica' | 'IU Inibitoria' | 'Scala globale';
  score: number;
  statistics?: {
    avarage: number;
    standardDeviation: number;
  };
};

const SIZE = 38;

export const Graph = (props: Props) => {
  const { score, statistics, label } = props;

  const normalizer = () => {
    switch (label) {
      case 'IU Prospettica':
        return SIZE / 35;
      case 'IU Inibitoria':
        return SIZE / 25;
      case 'Scala globale':
        return SIZE / 60;
    }
  };

  const getColor = () => {
    if (!statistics) return 'bg-forest-green-700';

    const { avarage, standardDeviation } = statistics;

    const pσ1 = avarage + standardDeviation;
    const pσ2 = avarage + 2 * standardDeviation;

    if (score > pσ2) return 'bg-red-400';
    if (score > pσ1) return 'bg-yellow-400';
    return 'bg-green-400';
  };

  const makeTicks = () => {
    if (!statistics) return null;
    const { avarage, standardDeviation } = statistics;
    const pσ1 = avarage + standardDeviation;
    const pσ2 = avarage + 2 * standardDeviation;
    const nσ1 = avarage - standardDeviation;
    const nσ2 = avarage - 2 * standardDeviation;

    return (
      <>
        <div
          style={{ left: `${nσ2 * normalizer()}rem` }}
          className="absolute -top-3"
        >
          <div className="h-10 w-[2px] rounded-md bg-black"></div>
          <p className="relative -left-4 mt-2">-2σ</p>
        </div>
        <div
          style={{ left: `${nσ1 * normalizer()}rem` }}
          className="absolute -top-3"
        >
          <div className="h-10 w-[2px] rounded-md bg-black"></div>
          <p className="relative -left-4 mt-2">-1σ</p>
        </div>
        <div
          style={{ left: `${avarage * normalizer()}rem` }}
          className="absolute -top-3"
        >
          <div className="h-10 w-[2px] rounded-md bg-black"></div>
          <p className="relative -left-7 mt-2">media</p>
        </div>
        <div
          style={{ left: `${pσ1 * normalizer()}rem` }}
          className="absolute -top-3"
        >
          <div className="h-10 w-[2px] rounded-md bg-black"></div>
          <p className="relative -left-2 mt-2">1σ</p>
        </div>
        <div
          style={{ left: `${pσ2 * normalizer()}rem` }}
          className="absolute -top-3"
        >
          <div className="h-10 w-[2px] rounded-md bg-black"></div>
          <p className="relative -left-2 mt-2">2σ</p>
        </div>
      </>
    );
  };

  return (
    <div>
      <span className="font-bold">{label}</span>
      <div
        style={{ width: `${SIZE}rem` }}
        className="relative my-10 h-4 rounded-md bg-gray-300"
      >
        <div className="absolute bottom-0 left-0 flex items-end justify-end">
          <div
            style={{ width: `${score * normalizer()}rem` }}
            className={cn('h-4 rounded-s-md', getColor())}
          ></div>
          <div
            className={cn('h-10 w-[2px] rounded-md text-white', getColor())}
          ></div>
          <span
            className={cn(
              'relative -left-4 -top-6 flex h-8 w-8 items-center justify-center rounded-full leading-none text-white',
              getColor()
            )}
          >
            {score}
          </span>
        </div>

        {makeTicks()}
      </div>
    </div>
  );
};

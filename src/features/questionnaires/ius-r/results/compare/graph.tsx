import { cn } from '@/utils/cn';

const SIZE = 36;

type Props = {
  prevScore: number;
  nextScore: number;
  prevT: number;
  nextT: number;
  label: 'IU Prospettica' | 'IU Inibitoria' | 'Scala globale';
  statistics?: {
    avarage: number;
    standardDeviation: number;
  };
};

export const Graph = (props: Props) => {
  const { prevScore, nextScore, prevT, nextT, label, statistics } = props;

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

  const getColor = (score: number) => {
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
          className="absolute -top-12"
        >
          <div className="h-20 w-[2px] rounded-md bg-black"></div>
          <p className="relative -left-4 mt-2">-2σ</p>
        </div>
        <div
          style={{ left: `${nσ1 * normalizer()}rem` }}
          className="absolute -top-12"
        >
          <div className="h-20 w-[2px] rounded-md bg-black"></div>
          <p className="relative -left-4 mt-2">-1σ</p>
        </div>
        <div
          style={{ left: `${avarage * normalizer()}rem` }}
          className="absolute -top-12"
        >
          <div className="h-20 w-[2px] rounded-md bg-black"></div>
          <p className="relative -left-7 mt-2">media</p>
        </div>
        <div
          style={{ left: `${pσ1 * normalizer()}rem` }}
          className="absolute -top-12"
        >
          <div className="h-20 w-[2px] rounded-md bg-black"></div>
          <p className="relative -left-2 mt-2">1σ</p>
        </div>
        <div
          style={{ left: `${pσ2 * normalizer()}rem` }}
          className="absolute -top-12"
        >
          <div className="h-20 w-[2px] rounded-md bg-black"></div>
          <p className="relative -left-2 mt-2">2σ</p>
        </div>
      </>
    );
  };

  return (
    <div className="relative">
      <span className="font-bold">{label}</span>
      <div className="my-10 space-y-4">
        <div className="grid grid-cols-[1rem,1fr] place-items-center gap-4">
          <span className="text-forest-green-700">T{prevT}</span>
          <div
            style={{ width: `${SIZE}rem` }}
            className="relative h-4 rounded-md bg-gray-300"
          >
            <div className="absolute bottom-0 left-0 flex items-end justify-end">
              <div
                style={{ width: `${prevScore * normalizer()}rem` }}
                className={cn('h-4 rounded-s-md', getColor(prevScore))}
              ></div>
              <div
                className={cn(
                  'h-10 w-[2px] rounded-md text-white',
                  getColor(prevScore)
                )}
              ></div>
              <span
                className={cn(
                  'relative -left-4 -top-6 flex h-8 w-8 items-center justify-center rounded-full leading-none text-white',
                  getColor(prevScore)
                )}
              >
                {prevScore}
              </span>
            </div>
          </div>
        </div>

        <div className="grid grid-cols-[1rem,1fr] place-items-center gap-4">
          <span className="text-forest-green-700">T{nextT}</span>
          <div
            style={{ width: `${SIZE}rem` }}
            className="relative h-4 rounded-md bg-gray-300"
          >
            <div className="absolute bottom-0 left-0 flex items-end justify-end">
              <div
                style={{ width: `${nextScore * normalizer()}rem` }}
                className={cn('h-4 rounded-s-md', getColor(nextScore))}
              ></div>
              <div
                className={cn(
                  'relative top-6 h-10 w-[2px] rounded-md text-white',
                  getColor(nextScore)
                )}
              ></div>
              <span
                className={cn(
                  'relative -left-4 top-10 flex h-8 w-8 items-center justify-center rounded-full leading-none text-white',
                  getColor(nextScore)
                )}
              >
                {nextScore}
              </span>
            </div>

            {makeTicks()}
          </div>
        </div>
      </div>
    </div>
  );
};

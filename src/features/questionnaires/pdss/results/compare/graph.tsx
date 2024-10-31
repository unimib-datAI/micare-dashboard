import { cn } from '@/utils/cn';

const SIZE = 42;

type Props = {
  prevScore: number;
  nextScore: number;
  prevT: number;
  nextT: number;
  cutOff: number;
};

export const Graph = (props: Props) => {
  const { prevScore, nextScore, prevT, nextT, cutOff } = props;

  const normalizer = () => SIZE / 4;

  const getColor = (score: number) => {
    if (score > cutOff) return 'bg-red-400';
    return 'bg-green-400';
  };

  const makeTicks = () => {
    return (
      <div
        style={{ left: `${cutOff * normalizer()}rem` }}
        className="absolute -top-14"
      >
        <div className="h-24 w-[2px] rounded-md bg-black"></div>
        <p className="relative -left-8 mt-2">Cut-off</p>
      </div>
    );
  };

  return (
    <div className="relative">
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

import { cn } from '@/utils/cn';

type Props = {
  score: number;
  cutOff: number;
};

const SIZE = 42;

export const Graph = (props: Props) => {
  const { score, cutOff } = props;

  const normalizer = () => SIZE / 4;

  const getColor = () => {
    if (score > cutOff) return 'bg-red-400';
    return 'bg-green-400';
  };

  const makeTicks = () => {
    return (
      <div
        style={{ left: `${cutOff * normalizer()}rem` }}
        className="absolute -top-3"
      >
        <div className="h-10 w-[2px] rounded-md bg-black"></div>
        <p className="relative -left-8 mt-2">Cut-off</p>
      </div>
    );
  };

  return (
    <div>
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

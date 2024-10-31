import { cn } from '@/utils/cn';

const WIDTH_DICT = {
  1: 'w-[4rem]',
  2: 'w-[8rem]',
  3: 'w-[12rem]',
  4: 'w-[16rem]',
  5: 'w-[20rem]',
  6: 'w-[24rem]',
  7: 'w-[28rem]',
  8: 'w-[32rem]',
  9: 'w-[36rem]',
  10: 'w-[40rem]',
  11: 'w-[44rem]',
  12: 'w-[48rem]',
  13: 'w-[52rem]',
  14: 'w-[56rem]',
  15: 'w-[60rem]',
  16: 'w-[64rem]',
} as { [key: string]: string };

type Props = {
  prevExpressedSymptomsCount: number;
  nextExpressedSymptomsCount: number;
  prevT: number;
  nextT: number;
};

export const ExpressedSymptomsGraph = (props: Props) => {
  const {
    prevExpressedSymptomsCount,
    nextExpressedSymptomsCount,
    prevT,
    nextT,
  } = props;

  const getBgColor = (count: number) => {
    if (count > 6) return 'bg-red-400';
    return 'bg-green-400';
  };

  return (
    <div className="relative grid">
      <div className="grid grid-cols-[auto,1fr] place-items-center">
        <div className="w-12">
          <span className="text-forest-green-700">T{prevT}</span>
        </div>
        <div className="relative h-4 w-[64rem] rounded-md bg-gray-300">
          <div className="absolute bottom-0 left-0 flex items-end justify-end">
            <div
              className={cn(
                'h-4 rounded-s-md',
                WIDTH_DICT[prevExpressedSymptomsCount.toString()],
                getBgColor(prevExpressedSymptomsCount)
              )}
            ></div>
            <div
              className={cn(
                'h-10 w-[2px] rounded-md text-white',
                getBgColor(prevExpressedSymptomsCount)
              )}
            ></div>
            <span
              className={cn(
                'relative -left-4 -top-6 flex h-8 w-8 items-center justify-center rounded-full leading-none text-white',
                getBgColor(prevExpressedSymptomsCount)
              )}
            >
              {prevExpressedSymptomsCount}
            </span>
          </div>
        </div>
      </div>

      <div className="grid grid-cols-[auto,1fr] place-items-center">
        <div className="w-12">
          <span className="text-forest-green-700">T{nextT}</span>
        </div>
        <div className="relative h-4 w-[64rem] rounded-md bg-gray-300">
          <div className="absolute bottom-0 left-0 flex items-end justify-end">
            <div
              className={cn(
                'h-4 rounded-s-md',
                WIDTH_DICT[nextExpressedSymptomsCount.toString()],
                getBgColor(nextExpressedSymptomsCount)
              )}
            ></div>
            <div
              className={cn(
                'relative top-6 h-10 w-[2px] rounded-md text-white',
                getBgColor(nextExpressedSymptomsCount)
              )}
            ></div>
            <span
              className={cn(
                'relative -left-4 top-12 flex h-8 w-8 items-center justify-center rounded-full leading-none text-white',
                getBgColor(nextExpressedSymptomsCount)
              )}
            >
              {nextExpressedSymptomsCount}
            </span>
          </div>
        </div>
        <div className="absolute -top-4 left-[24rem] ml-12">
          <div className="h-20 w-[2px] rounded-md bg-black"></div>
          <p className="relative -left-7 mt-2">Cut-off</p>
        </div>
      </div>
    </div>
  );
};

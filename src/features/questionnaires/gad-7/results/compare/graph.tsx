import { cn } from '@/utils/cn';

const WIDTH_DICT = {
  1: 'w-[3rem]',
  2: 'w-[6rem]',
  3: 'w-[9rem]',
  4: 'w-[12rem]',
  5: 'w-[15rem]',
  6: 'w-[18rem]',
  7: 'w-[21rem]',
  8: 'w-[24rem]',
  9: 'w-[27rem]',
  10: 'w-[30rem]',
  11: 'w-[33rem]',
  12: 'w-[36rem]',
  13: 'w-[39rem]',
  14: 'w-[42rem]',
  15: 'w-[45rem]',
  16: 'w-[48rem]',
  17: 'w-[51rem]',
  18: 'w-[54rem]',
  19: 'w-[57rem]',
  20: 'w-[60rem]',
  21: 'w-[64rem]',
} as { [key: string]: string };

type Props = {
  prevScore: number;
  nextScore: number;
  prevT: number;
  nextT: number;
  cutOff: number;
};

export const Graph = (props: Props) => {
  const { prevScore, nextScore, prevT, nextT, cutOff } = props;

  const getColor = (score: number) => {
    return score > cutOff ? 'bg-red-400' : 'bg-green-400';
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
                WIDTH_DICT[prevScore.toString()],
                getColor(prevScore)
              )}
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

      <div className="grid grid-cols-[auto,1fr] place-items-center">
        <div className="w-12">
          <span className="text-forest-green-700">T{nextT}</span>
        </div>
        <div className="relative h-4 w-[64rem] rounded-md bg-gray-300">
          <div className="absolute bottom-0 left-0 flex items-end justify-end">
            <div
              className={cn(
                'h-4 rounded-s-md',
                WIDTH_DICT[nextScore.toString()],
                getColor(nextScore)
              )}
            ></div>
            <div
              className={cn(
                'relative top-6 h-10 w-[2px] rounded-md text-white',
                getColor(nextScore)
              )}
            ></div>
            <span
              className={cn(
                'relative -left-4 top-12 flex h-8 w-8 items-center justify-center rounded-full leading-none text-white',
                getColor(nextScore)
              )}
            >
              {nextScore}
            </span>
          </div>
        </div>

        <div className="absolute -top-4  left-[0rem] ml-12">
          <div className="h-20 w-[2px] rounded-md bg-black"></div>
          <p className="relative -left-7 mt-2">Assente</p>
        </div>
        <div className="absolute -top-3 left-[15rem]">
          <div className="h-20 w-[2px] rounded-md bg-black"></div>
          <p className="relative -left-5 mt-2">Lieve</p>
        </div>
        <div className="absolute -top-3 left-[30rem]">
          <div className="h-20 w-[2px] rounded-md bg-black"></div>
          <p className="relative -left-9 mt-2">Moderata</p>
        </div>
        <div className="absolute -top-3 left-[45rem]">
          <div className="h-20 w-[2px] rounded-md bg-black"></div>
          <p className="relative -left-6 mt-2">Grave</p>
        </div>
      </div>
    </div>
  );
};
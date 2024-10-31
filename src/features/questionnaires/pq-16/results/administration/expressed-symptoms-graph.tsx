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
  expressedSymptomsCount: number;
};

export const ExpressedSymptomsGraph = (props: Props) => {
  const { expressedSymptomsCount } = props;

  return (
    <div className="relative h-4 w-[64rem] rounded-md bg-gray-300">
      <div className="absolute bottom-0 left-0 flex items-end justify-end">
        <div
          className={cn(
            'h-4 rounded-s-md',
            WIDTH_DICT[expressedSymptomsCount.toString()],
            expressedSymptomsCount > 6 ? 'bg-red-400' : 'bg-green-400'
          )}
        ></div>
        <div
          className={cn(
            'h-10 w-[2px] rounded-md text-white',
            expressedSymptomsCount > 6 ? 'bg-red-400' : 'bg-green-400'
          )}
        ></div>
        <span
          className={cn(
            'relative -left-4 -top-6 flex h-8 w-8 items-center justify-center rounded-full leading-none text-white',
            expressedSymptomsCount > 6 ? 'bg-red-400' : 'bg-green-400'
          )}
        >
          {expressedSymptomsCount}
        </span>
      </div>

      <div className="absolute -top-3 left-[24rem]">
        <div className="h-10 w-[2px] rounded-md bg-black"></div>
        <p className="relative -left-7 mt-2">Cut-off</p>
      </div>
    </div>
  );
};

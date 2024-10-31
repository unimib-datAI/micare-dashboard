import { cn } from '@/utils/cn';

const WIDTH_DICT = {
  1: 'w-[1.33rem]',
  2: 'w-[2.67rem]',
  3: 'w-[4rem]',
  4: 'w-[5.33rem]',
  5: 'w-[6.67rem]',
  6: 'w-[8rem]',
  7: 'w-[9.33rem]',
  8: 'w-[10.67rem]',
  9: 'w-[12rem]',
  10: 'w-[13.33rem]',
  11: 'w-[14.67rem]',
  12: 'w-[16rem]',
  13: 'w-[17.33rem]',
  14: 'w-[18.67rem]',
  15: 'w-[20rem]',
  16: 'w-[21.33rem]',
  17: 'w-[22.67rem]',
  18: 'w-[24rem]',
  19: 'w-[25.33rem]',
  20: 'w-[26.67rem]',
  21: 'w-[28rem]',
  22: 'w-[29.33rem]',
  23: 'w-[30.67rem]',
  24: 'w-[32rem]',
  25: 'w-[33.33rem]',
  26: 'w-[34.67rem]',
  27: 'w-[36rem]',
  28: 'w-[37.33rem]',
  29: 'w-[38.67rem]',
  30: 'w-[40rem]',
  31: 'w-[41.33rem]',
  32: 'w-[42.67rem]',
  33: 'w-[44rem]',
  34: 'w-[45.33rem]',
  35: 'w-[46.67rem]',
  36: 'w-[48rem]',
  37: 'w-[49.33rem]',
  38: 'w-[50.67rem]',
  39: 'w-[52rem]',
  40: 'w-[53.33rem]',
  41: 'w-[54.67rem]',
  42: 'w-[56rem]',
  43: 'w-[57.33rem]',
  44: 'w-[58.67rem]',
  45: 'w-[60rem]',
  46: 'w-[61.33rem]',
  47: 'w-[62.67rem]',
  48: 'w-[64rem]',
} as { [key: string]: string };

type Props = {
  expressedSymptoms: [string, { value: string; score?: string | undefined }][];
};

export const DistressGraph = (props: Props) => {
  const { expressedSymptoms } = props;

  const expressedSymptomsScore = expressedSymptoms
    .map(([, record]) => parseInt(record.score as string) || 0)
    .reduce((acc, score) => acc + score, 0);

  return (
    <div className="relative h-4 w-[64rem] rounded-md bg-gray-300">
      <div className="absolute bottom-0 left-0 flex items-end justify-end">
        <div
          className={cn(
            'h-4 rounded-s-md',
            WIDTH_DICT[expressedSymptomsScore.toString()],
            expressedSymptomsScore > 8 ? 'bg-red-400' : 'bg-green-400'
          )}
        ></div>
        <div
          className={cn(
            'h-10 w-[2px] rounded-md text-white',
            expressedSymptomsScore > 8 ? 'bg-red-400' : 'bg-green-400'
          )}
        ></div>
        <span
          className={cn(
            'relative -left-4 -top-6 flex h-8 w-8 items-center justify-center rounded-full leading-none text-white',
            expressedSymptomsScore > 8 ? 'bg-red-400' : 'bg-green-400'
          )}
        >
          {expressedSymptomsScore}
        </span>
      </div>

      <div className="absolute -top-3 left-[10.67rem]">
        <div className="h-10 w-[2px] rounded-md bg-black"></div>
        <p className="relative -left-7 mt-2">Cut-off</p>
      </div>
    </div>
  );
};
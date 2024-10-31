import { type FormValues } from '@/features/questionnaires/pq-16/pq16-item';
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
  prevResponse: FormValues;
  nextResponse: FormValues;
  prevT: number;
  nextT: number;
};

export const DistressGraph = (props: Props) => {
  const { prevResponse, nextResponse, prevT, nextT } = props;

  const expressedSymptoms = Object.entries(prevResponse).map(
    ([index, record]) => {
      return {
        index,
        prevRecord: record,
        nextRecord: nextResponse[index] ?? { value: 'false' },
      };
    }
  );

  const prexExpressedSymptomsScore = expressedSymptoms.reduce((acc, item) => {
    const { prevRecord } = item;
    if (!prevRecord.score) return acc;
    return acc + parseInt(prevRecord.score);
  }, 0);
  const nextExpressedSymptomsCount = expressedSymptoms.reduce((acc, item) => {
    const { nextRecord } = item;
    if (!nextRecord.score) return acc;
    return acc + parseInt(nextRecord.score);
  }, 0);

  const getBgColor = (count: number) => {
    if (count > 8) return 'bg-red-400';
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
                WIDTH_DICT[prexExpressedSymptomsScore.toString()],
                getBgColor(prexExpressedSymptomsScore)
              )}
            ></div>
            <div
              className={cn(
                'h-10 w-[2px] rounded-md text-white',
                getBgColor(prexExpressedSymptomsScore)
              )}
            ></div>
            <span
              className={cn(
                'relative -left-4 -top-6 flex h-8 w-8 items-center justify-center rounded-full leading-none text-white',
                getBgColor(prexExpressedSymptomsScore)
              )}
            >
              {prexExpressedSymptomsScore}
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
        <div className="absolute -top-4 left-[10.67rem] ml-12">
          <div className="h-20 w-[2px] rounded-md bg-black"></div>
          <p className="relative -left-7 mt-2">Cut-off</p>
        </div>
      </div>
    </div>
  );
};

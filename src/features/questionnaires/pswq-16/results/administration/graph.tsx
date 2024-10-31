import { cn } from '@/utils/cn';

const WIDTH_DICT = {
  16: 'w-[12.8rem]',
  17: 'w-[13.6rem]',
  18: 'w-[14.4rem]',
  19: 'w-[15.2rem]',
  20: 'w-[16rem]',
  21: 'w-[16.8rem]',
  22: 'w-[17.6rem]',
  23: 'w-[18.4rem]',
  24: 'w-[19.2rem]',
  25: 'w-[20rem]',
  26: 'w-[20.8rem]',
  27: 'w-[21.6rem]',
  28: 'w-[22.4rem]',
  29: 'w-[23.2rem]',
  30: 'w-[24rem]',
  31: 'w-[24.8rem]',
  32: 'w-[25.6rem]',
  33: 'w-[26.4rem]',
  34: 'w-[27.2rem]',
  35: 'w-[28rem]',
  36: 'w-[28.8rem]',
  37: 'w-[29.6rem]',
  38: 'w-[30.4rem]',
  39: 'w-[31.2rem]',
  40: 'w-[32rem]',
  41: 'w-[32.8rem]',
  42: 'w-[33.6rem]',
  43: 'w-[34.4rem]',
  44: 'w-[35.2rem]',
  45: 'w-[36rem]',
  46: 'w-[36.8rem]',
  47: 'w-[37.6rem]',
  48: 'w-[38.4rem]',
  49: 'w-[39.2rem]',
  50: 'w-[40rem]',
  51: 'w-[40.8rem]',
  52: 'w-[41.6rem]',
  53: 'w-[42.4rem]',
  54: 'w-[43.2rem]',
  55: 'w-[44rem]',
  56: 'w-[44.8rem]',
  57: 'w-[45.6rem]',
  58: 'w-[46.4rem]',
  59: 'w-[47.2rem]',
  60: 'w-[48rem]',
  61: 'w-[48.8rem]',
  62: 'w-[49.6rem]',
  63: 'w-[50.4rem]',
  64: 'w-[51.2rem]',
  65: 'w-[52rem]',
  66: 'w-[52.8rem]',
  67: 'w-[53.6rem]',
  68: 'w-[54.4rem]',
  69: 'w-[55.2rem]',
  70: 'w-[56rem]',
  71: 'w-[56.8rem]',
  72: 'w-[57.6rem]',
  73: 'w-[58.4rem]',
  74: 'w-[59.2rem]',
  75: 'w-[60rem]',
  76: 'w-[60.8rem]',
  77: 'w-[61.6rem]',
  78: 'w-[62.4rem]',
  79: 'w-[63.2rem]',
  80: 'w-[64rem]',
} as { [key: string]: string };

type Props = {
  score: number;
  avarage: number | undefined;
  standardDeviation: number | undefined;
};

export const Graph = (props: Props) => {
  const { score, avarage, standardDeviation } = props;

  if (avarage === undefined || standardDeviation === undefined) return null;

  const pσ1 = avarage + standardDeviation;
  const pσ2 = avarage + 2 * standardDeviation;
  const nσ1 = avarage - standardDeviation;
  const nσ2 = avarage - 2 * standardDeviation;

  const normalizer = 64 / 80;

  const getColor = () => {
    if (avarage === undefined || standardDeviation === undefined) return 0;

    if (score > avarage + 2 * standardDeviation) return 'bg-red-400';
    if (score > avarage + standardDeviation) return 'bg-yellow-400';
    return 'bg-green-400';
  };

  return (
    <div className="relative h-4 w-[64rem] rounded-md bg-gray-300">
      <div className="absolute bottom-0 left-0 flex items-end justify-end">
        <div
          className={cn('h-4 rounded-s-md', WIDTH_DICT[score], getColor())}
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

      {standardDeviation !== 0 ? (
        <>
          <div
            style={{ left: `${nσ2 * normalizer}rem` }}
            className="absolute -top-3"
          >
            <div className="h-10 w-[2px] rounded-md bg-black"></div>
            <p className="relative -left-4 mt-2">-2σ</p>
          </div>
          <div
            style={{ left: `${nσ1 * normalizer}rem` }}
            className="absolute -top-3"
          >
            <div className="h-10 w-[2px] rounded-md bg-black"></div>
            <p className="relative -left-4 mt-2">-1σ</p>
          </div>
          <div
            style={{ left: `${avarage * normalizer}rem` }}
            className="absolute -top-3"
          >
            <div className="h-10 w-[2px] rounded-md bg-black"></div>
            <p className="relative -left-9 mt-2">media</p>
          </div>
          <div
            style={{ left: `${pσ1 * normalizer}rem` }}
            className="absolute -top-3"
          >
            <div className="h-10 w-[2px] rounded-md bg-black"></div>
            <p className="relative -left-2 mt-2">1σ</p>
          </div>
          <div
            style={{ left: `${pσ2 * normalizer}rem` }}
            className="absolute -top-3"
          >
            <div className="h-10 w-[2px] rounded-md bg-black"></div>
            <p className="relative -left-2 mt-2">2σ</p>
          </div>
        </>
      ) : (
        <div
          style={{ left: `${avarage * normalizer}rem` }}
          className="absolute -top-3 left-[30rem]"
        >
          <p className="relative -left-28 top-10 mt-2 text-gray-400">
            Nessun dato da confrontare
          </p>
        </div>
      )}
    </div>
  );
};

import { AlignLeft, ScatterChart } from 'lucide-react';
import { createContext, useContext, useState } from 'react';

import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from '@/components/ui/card';
import { ToggleGroup, ToggleGroupItem } from '@/components/ui/toggle-group';
import { type FormValues } from '@/features/questionnaires/ius-r/item';

import { DetailsDots } from './details-dots';
import { DetailsList } from './details-list';

type Context = {
  scale: string;
  view: string;
  T: number;
  response: FormValues['response'];
};

const cardContext = createContext<Context>({
  scale: 'global',
  view: 'dots',
  T: 0,
  response: {},
});

type ContextProviderProps = {
  children: React.ReactNode;
  response: FormValues['response'];
  T: number;
  view: string;
  scale: string;
};
const ContextProvider = ({
  children,
  response,
  T,
  view,
  scale,
}: ContextProviderProps) => (
  <cardContext.Provider
    value={{
      scale,
      view,
      T,
      response,
    }}
  >
    {children}
  </cardContext.Provider>
);

const getItems = (response: FormValues['response'], scale: string) => {
  if (scale === 'prospective') {
    return Object.fromEntries(
      Object.entries(response).filter(([key]) => +key.split('-')[1] <= 7)
    );
  }
  if (scale === 'inhibitory') {
    return Object.fromEntries(
      Object.entries(response).filter(([key]) => +key.split('-')[1] > 7)
    );
  }
  return response;
};

const Scale = () => {
  const { response, scale, view, T } = useContext(cardContext);

  const items = getItems(response, scale);

  return view === 'dots' ? (
    <DetailsDots T={T} responses={items} />
  ) : (
    <DetailsList responses={items} />
  );
};

type Props = {
  response: FormValues['response'];
  avarage: number;
  standardDeviation: number;
  T: number;
};
export const DetailsCard = (props: Props) => {
  const { response, avarage, standardDeviation, T } = props;

  const [scale, setScale] = useState<string>('global');
  const [view, setView] = useState<string>('dots');

  return (
    <ContextProvider response={response} T={T} view={view} scale={scale}>
      <Card className="w-fit">
        <CardHeader>
          <CardTitle className="flex items-center justify-between">
            Sintomi espressi
            <div className="flex items-center text-sm font-normal">
              <ToggleGroup
                type="single"
                value={view}
                onValueChange={(value) => setView(value)}
                className="justify-end gap-0 rounded-md bg-input pr-0"
              >
                <ToggleGroupItem value="dots" size="sm">
                  <ScatterChart className="mr-1 h-5 w-5" /> Sintesi
                </ToggleGroupItem>
                <ToggleGroupItem value="list" size="sm">
                  <AlignLeft className="mr-1 h-5 w-5" /> Dettagli
                </ToggleGroupItem>
              </ToggleGroup>
            </div>
          </CardTitle>
          <CardDescription className="flex">
            <span>M = {avarage}</span>
            <span>&nbsp;|&nbsp;</span>
            <span>DS = {standardDeviation}</span>
          </CardDescription>
        </CardHeader>
        <CardContent className="grid w-[41rem] items-center gap-4">
          <ToggleGroup
            type="single"
            value={scale}
            onValueChange={(value) => setScale(value)}
            className="flex w-full gap-0 rounded-md bg-input"
          >
            <ToggleGroupItem value="global" size="sm" className="flex-1">
              Scala globale
            </ToggleGroupItem>
            <ToggleGroupItem value="prospective" size="sm" className="flex-1">
              IU Prospettica
            </ToggleGroupItem>
            <ToggleGroupItem value="inhibitory" size="sm" className="flex-1">
              IU Inibitoria
            </ToggleGroupItem>
          </ToggleGroup>
          <Scale />
        </CardContent>
      </Card>
    </ContextProvider>
  );
};

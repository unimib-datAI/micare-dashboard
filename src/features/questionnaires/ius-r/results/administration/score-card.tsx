import { AlignLeft, LoaderCircle } from 'lucide-react';
import { useState } from 'react';

import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from '@/components/ui/card';
import { Separator } from '@/components/ui/separator';
import { ToggleGroup, ToggleGroupItem } from '@/components/ui/toggle-group';

import { Chart } from './chart';
import { Graph } from './graph';

type Props = {
  score: {
    prospective: number;
    inhibitory: number;
  };
  avarage: number;
  standardDeviation: number;
};
export const ScoreCard = (props: Props) => {
  const { score, avarage, standardDeviation } = props;

  const [toggleGraph, setToggleGraph] = useState<string>('chart');

  return (
    <Card className="w-fit">
      <CardHeader>
        <CardTitle className="flex items-center justify-between">
          Punteggio
          <div className="flex items-center text-sm font-normal">
            <ToggleGroup
              type="single"
              value={toggleGraph}
              onValueChange={(value) => setToggleGraph(value)}
              className="justify-end gap-0 rounded-md bg-input pr-0"
            >
              <ToggleGroupItem value="chart" size="sm">
                <LoaderCircle className="mr-1 h-5 w-5" /> Sintesi
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
      <CardContent className="flex w-[41rem] items-center gap-12">
        {toggleGraph === 'chart' ? (
          <>
            <Chart
              score={score.inhibitory + score.prospective}
              label="Scala globale"
              statistics={{ avarage, standardDeviation }}
            />
            <Separator orientation="vertical" className="w-1px mt-7 h-28" />
            <Chart score={score.prospective} label="IU Prospettica" />
            <Chart score={score.inhibitory} label="IU Inibitoria" />
          </>
        ) : (
          <div className="grid space-y-4">
            <Graph
              label="Scala globale"
              score={score.inhibitory + score.prospective}
              statistics={{ avarage, standardDeviation }}
            />
            <Separator className="w-full" />
            <Graph label="IU Prospettica" score={score.prospective} />
            <Graph label="IU Inibitoria" score={score.inhibitory} />
          </div>
        )}
      </CardContent>
    </Card>
  );
};

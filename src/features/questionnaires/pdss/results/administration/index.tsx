import { List, Maximize2, ScatterChart } from 'lucide-react';
import { type NextPage } from 'next';
import { useRouter } from 'next/router';
import { useState } from 'react';

import {
  Card,
  CardContent,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle,
} from '@/components/ui/card';
import {
  Collapsible,
  CollapsibleContent,
  CollapsibleTrigger,
} from '@/components/ui/collapsible';
import { Shimmer } from '@/components/ui/schimmer';
import { ToggleGroup, ToggleGroupItem } from '@/components/ui/toggle-group';
import { AdministrationCardDetail } from '@/features/questionnaires/components/administration-card-detail';
import { type FormValues } from '@/features/questionnaires/pdss/item';
import { _default as RootLayout, PatientLayout } from '@/layout';
import { type TView } from '@/types/view-types';
import { api } from '@/utils/api';
import { dateFormatting } from '@/utils/date-formatter';

import { DetailsDots } from './details-dots';
import { DetailsList } from './details-list';
import { Graph } from './graph';

const CUT_OFF = 1.28;

const AdministrationResultsPswq16: NextPage = () => {
  const router = useRouter();
  const { view } = router.query as { view: TView };
  const [_, administration] = view;
  const [toggleValue, setToggleValue] = useState('dots');

  const { data: currentAdministration, isLoading } =
    api.administration.findUnique.useQuery(
      {
        where: {
          id: administration,
        },
      },
      {
        enabled: !!administration,
      }
    );

  if (!currentAdministration || isLoading)
    return <Shimmer className="h-full w-full" />;

  const records = currentAdministration.administration.records as FormValues;

  const response = records.response;
  const score = records.score;

  if (response === undefined || score === undefined) return null;

  return (
    <div className="flex flex-col gap-8">
      {isLoading ? (
        <Shimmer className="h-full w-full" />
      ) : (
        <AdministrationCardDetail
          testType={
            currentAdministration.administration.type ?? 'Dato non trovato'
          }
          testNumber={`T${currentAdministration.administration.T ?? ''}`}
          date={dateFormatting(
            currentAdministration.administration.date ?? new Date(),
            'dd/MM/yyyy'
          )}
        />
      )}
      <Card className="w-fit">
        <CardHeader>
          <CardTitle>Punteggio</CardTitle>
          <CardDescription>Cut-off: {CUT_OFF}</CardDescription>
        </CardHeader>
        <CardContent className="grid grid-cols-[auto,1fr] place-items-center gap-8">
          <p className="w-10 text-lg font-bold text-forest-green-700">
            {score}/4
          </p>
          <Graph score={score} cutOff={CUT_OFF} />
        </CardContent>
        <CardFooter>
          <Collapsible className="mt-4 grid w-full grid-cols-1">
            <CollapsibleTrigger className="justify-self-end">
              <Maximize2 />
            </CollapsibleTrigger>
            <CollapsibleContent>
              <ToggleGroup
                type="single"
                variant="outline"
                value={toggleValue}
                onValueChange={(value) => setToggleValue(value)}
                className="justify-end p-4 pr-0"
              >
                <ToggleGroupItem value="dots">
                  <ScatterChart />
                </ToggleGroupItem>
                <ToggleGroupItem value="list">
                  <List />
                </ToggleGroupItem>
              </ToggleGroup>
              {toggleValue === 'dots' ? (
                <DetailsDots
                  T={currentAdministration.administration.T ?? 0}
                  responses={response}
                />
              ) : (
                <DetailsList responses={response} />
              )}
            </CollapsibleContent>
          </Collapsible>
        </CardFooter>
      </Card>
    </div>
  );
};

export default AdministrationResultsPswq16;

AdministrationResultsPswq16.getLayout = (page) => {
  return (
    <RootLayout>
      <PatientLayout>{page}</PatientLayout>
    </RootLayout>
  );
};

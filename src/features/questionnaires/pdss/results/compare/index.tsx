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
import { columnsCompare } from '@/features/questionnaires/components/table/columns';
import { AdministrationResultsTable } from '@/features/questionnaires/components/table/table';
import { type FormValues } from '@/features/questionnaires/pdss/item';
import { _default as RootLayout, PatientLayout } from '@/layout';
import { api } from '@/utils/api';

import { DetailsDots } from './details-dots';
import { DetailsList } from './details-list';
import { Graph } from './graph';

const CUT_OFF = 1.28;

const AdministrationResultsPswq16: NextPage = () => {
  const router = useRouter();
  const { comparison } = router.query;
  console.log(comparison);
  const [tA, tB] = (comparison as [string, string]) ?? [];

  const [toggleValue, setToggleValue] = useState('dots');

  const { data, isLoading } = api.administration.findMany.useQuery(
    {
      where: {
        OR: [{ id: tA }, { id: tB }],
      },
      orderBy: {
        T: 'asc',
      },
    },
    {
      enabled: !!comparison || !!tA || !!tB,
    }
  );

  if (!data || isLoading) return <Shimmer className="h-full w-full" />;

  const [prevAdministration, nextAdministration] = data;

  if (!prevAdministration || !nextAdministration)
    return (
      <p>
        Errore nel ritrovamento delle informazioni relative alle
        somministrazioni.
      </p>
    );

  const prevRecords = prevAdministration?.records as FormValues;
  const nextRecords = nextAdministration?.records as FormValues;

  const prevResponse = prevRecords.response;
  const nextResponse = nextRecords.response;

  const prevScore = prevRecords.score;
  const nextScore = nextRecords.score;

  if (
    prevResponse === undefined ||
    prevScore === undefined ||
    nextResponse === undefined ||
    nextScore === undefined
  )
    return null;

  return (
    <div className="flex flex-col gap-8">
      {isLoading ? (
        <Shimmer className="h-full w-full" />
      ) : (
        <div className="flex flex-col gap-8">
          <section>
            <h2 className="font-h2 pb-4">
              Panic Disorder Severity Scale (PDSS)
            </h2>
            <div className="flex w-1/3 flex-col">
              <AdministrationResultsTable
                columns={columnsCompare}
                data={[prevAdministration, nextAdministration]}
                questionnaire="cba-ve"
              />
            </div>
          </section>

          <section>
            <Card className="w-fit">
              <CardHeader>
                <CardTitle>Sintomi espressi</CardTitle>
                <CardDescription>Cut-off: {CUT_OFF}</CardDescription>
              </CardHeader>
              <CardContent>
                <Graph
                  prevScore={prevScore}
                  nextScore={nextScore}
                  prevT={prevAdministration.T ?? 0}
                  nextT={nextAdministration.T ?? 0}
                  cutOff={CUT_OFF}
                />
              </CardContent>
              <CardFooter className="max-w-[47rem]">
                <Collapsible className="mt-4 grid w-full grid-cols-1">
                  <CollapsibleTrigger className="justify-self-end pb-4">
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
                        prevResponse={prevResponse}
                        nextResponse={nextResponse}
                        prevT={prevAdministration.T ?? 0}
                        nextT={nextAdministration.T ?? 0}
                      />
                    ) : (
                      <DetailsList
                        prevResponses={prevResponse}
                        nextResponses={nextResponse}
                        prevT={prevAdministration.T ?? 0}
                        nextT={nextAdministration.T ?? 0}
                      />
                    )}
                  </CollapsibleContent>
                </Collapsible>
              </CardFooter>
            </Card>
          </section>
        </div>
      )}
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

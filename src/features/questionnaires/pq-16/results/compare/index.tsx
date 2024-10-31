import { Maximize2 } from 'lucide-react';
import { type NextPage } from 'next';
import { useRouter } from 'next/router';

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
import { columnsCompare } from '@/features/questionnaires/components/table/columns';
import { AdministrationResultsTable } from '@/features/questionnaires/components/table/table';
import { type FormValues } from '@/features/questionnaires/pq-16/pq16-item';
import { _default as RootLayout, PatientLayout } from '@/layout';
import { api } from '@/utils/api';

import { ComparisonCards } from './comparison-cards';
import { DistressDetails } from './distress-details';
import { DistressGraph } from './distress-graph';
import { ExpressedSymptomsDetails } from './expressed-symptoms-details';
import { ExpressedSymptomsGraph } from './expressed-symptoms-graph';

const AdministrationResultsPQ16: NextPage = () => {
  const router = useRouter();
  const { comparison } = router.query;
  const [tA, tB] = (comparison as [string, string]) ?? [];

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

  console.log({ prevAdministration, nextAdministration });

  const prevRecords = prevAdministration?.records as {
    response: FormValues;
  };
  const nextRecords = nextAdministration?.records as {
    response: FormValues;
  };

  const prevResponse = prevRecords.response;
  const nextResponse = nextRecords.response;

  const prevExpressedSymptoms = Object.entries(prevResponse).filter(
    ([, record]) => record.value === 'true'
  );
  const prevExpressedSymptomsCount = prevExpressedSymptoms.length;
  const prevExpressedSymptomsScore = prevExpressedSymptoms
    .map(([, record]) => parseInt(record.score as string) || 0)
    .reduce((acc, score) => acc + score, 0);

  const nextExpressedSymptoms = Object.entries(nextResponse).filter(
    ([, record]) => record.value === 'true'
  );
  const nextExpressedSymptomsCount = nextExpressedSymptoms.length;
  const nextExpressedSymptomsScore = nextExpressedSymptoms
    .map(([, record]) => parseInt(record.score as string) || 0)
    .reduce((acc, score) => acc + score, 0);

  return (
    <div className="flex flex-col gap-8">
      {isLoading ? (
        <Shimmer className="h-full w-full" />
      ) : (
        <div className="flex flex-col gap-8">
          <section>
            <h2 className="font-h2 pb-4">
              Questionario dei sintomi podromici (PQ-16)
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
            <h2 className="font-h2 pb-4">Differenza tra le somministrazioni</h2>
            <ComparisonCards
              nextExpressedSymptomsCount={nextExpressedSymptomsCount}
              nextExpressedSymptomsScore={nextExpressedSymptomsScore}
              prevExpressedSymptomsCount={prevExpressedSymptomsCount}
              prevExpressedSymptomsScore={prevExpressedSymptomsScore}
            />
          </section>

          <section>
            <Card className="w-fit">
              <CardHeader>
                <CardTitle>Sintomi espressi</CardTitle>
                <CardDescription>Cut-off = 6</CardDescription>
              </CardHeader>
              <CardContent>
                <ExpressedSymptomsGraph
                  prevExpressedSymptomsCount={prevExpressedSymptomsCount}
                  nextExpressedSymptomsCount={nextExpressedSymptomsCount}
                  prevT={prevAdministration.T ?? 0}
                  nextT={nextAdministration.T ?? 0}
                />
              </CardContent>
              <CardFooter>
                <Collapsible className="mt-4 grid w-full grid-cols-1">
                  <CollapsibleTrigger className="justify-self-end pb-4">
                    <Maximize2 />
                  </CollapsibleTrigger>
                  <CollapsibleContent>
                    <ExpressedSymptomsDetails
                      prevResponse={prevResponse}
                      nextResponse={nextResponse}
                    />
                  </CollapsibleContent>
                </Collapsible>
              </CardFooter>
            </Card>

            <Card className="mt-8 w-fit">
              <CardHeader>
                <CardTitle>Distress</CardTitle>
                <CardDescription>Cut-off = 8</CardDescription>
              </CardHeader>
              <CardContent>
                <DistressGraph
                  nextResponse={nextResponse}
                  prevResponse={prevResponse}
                  prevT={prevAdministration.T ?? 0}
                  nextT={nextAdministration.T ?? 0}
                />
              </CardContent>
              <CardFooter>
                <Collapsible className="mt-4 grid w-full grid-cols-1">
                  <CollapsibleTrigger className="justify-self-end pb-4">
                    <Maximize2 />
                  </CollapsibleTrigger>
                  <CollapsibleContent>
                    <DistressDetails
                      prevResponse={prevResponse}
                      nextResponse={nextResponse}
                      prevT={prevAdministration.T ?? 0}
                      nextT={nextAdministration.T ?? 0}
                    />
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

export default AdministrationResultsPQ16;

AdministrationResultsPQ16.getLayout = (page) => {
  return (
    <RootLayout>
      <PatientLayout>{page}</PatientLayout>
    </RootLayout>
  );
};

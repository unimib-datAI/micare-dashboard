import { Maximize2 } from 'lucide-react';
import { type NextPage } from 'next';
import { useRouter } from 'next/router';

import {
  Card,
  CardContent,
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
import { type FormValues } from '@/features/questionnaires/gaf-sofas/item';
import { _default as RootLayout, PatientLayout } from '@/layout';
import { api } from '@/utils/api';

import { Details } from './details';
import { Graph } from './graph';

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

  const prevRecords = prevAdministration?.records as {
    response: FormValues;
  };
  const nextRecords = nextAdministration?.records as {
    response: FormValues;
  };

  const prevResponse = prevRecords.response;
  const nextResponse = nextRecords.response;

  return (
    <div className="flex flex-col gap-8">
      {isLoading ? (
        <Shimmer className="h-full w-full" />
      ) : (
        <div className="flex flex-col gap-8">
          <section>
            <h2 className="font-h2 pb-4">
              Scala per la Valutazione Globale del Funzionamento (VGF)
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
                <CardTitle>Punteggio</CardTitle>
              </CardHeader>
              <CardContent>
                <Graph
                  prevScore={prevResponse.value}
                  nextScore={nextResponse.value}
                  prevT={prevAdministration.T ?? 0}
                  nextT={nextAdministration.T ?? 0}
                />
              </CardContent>
              <CardFooter>
                <Collapsible className="mt-4 grid w-[1200px] grid-cols-1">
                  <CollapsibleTrigger className="justify-self-end pb-4">
                    <Maximize2 />
                  </CollapsibleTrigger>
                  <CollapsibleContent>
                    <Details
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

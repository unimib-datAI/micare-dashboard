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
import { AdministrationCardDetail } from '@/features/questionnaires/components/administration-card-detail';
import { type FormValues } from '@/features/questionnaires/gaf-sofas/item';
import { _default as RootLayout, PatientLayout } from '@/layout';
import { type TView } from '@/types/view-types';
import { api } from '@/utils/api';
import { dateFormatting } from '@/utils/date-formatter';

import { Details } from './details';
import { Graph } from './graph';

const AdministrationResultsGafsofas: NextPage = () => {
  const router = useRouter();
  const { view } = router.query as { view: TView };
  const [_, administration] = view;
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

  const records = currentAdministration.administration.records as {
    response: FormValues;
  };

  const response = records.response;

  const score = response.value[0];

  if (!score) return null;

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
        </CardHeader>
        <CardContent className="grid grid-cols-[auto,1fr] place-items-center gap-12">
          <p className="w-20 text-lg font-bold text-forest-green-700">
            {score}/100
          </p>
          <Graph score={score} />
        </CardContent>
        <CardFooter>
          <Collapsible className="mt-4 grid w-[1200px] grid-cols-1">
            <CollapsibleTrigger className="justify-self-end">
              <Maximize2 />
            </CollapsibleTrigger>
            <CollapsibleContent>
              <Details score={score} />
            </CollapsibleContent>
          </Collapsible>
        </CardFooter>
      </Card>
    </div>
  );
};

export default AdministrationResultsGafsofas;

AdministrationResultsGafsofas.getLayout = (page) => {
  return (
    <RootLayout>
      <PatientLayout>{page}</PatientLayout>
    </RootLayout>
  );
};

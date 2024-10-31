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
import { AdministrationCardDetail } from '@/features/questionnaires/components/administration-card-detail';
import { type FormValues } from '@/features/questionnaires/pq-16/pq16-item';
import { _default as RootLayout, PatientLayout } from '@/layout';
import { type TView } from '@/types/view-types';
import { api } from '@/utils/api';
import { dateFormatting } from '@/utils/date-formatter';

import { DistressDetails } from './distress-details';
import { DistressGraph } from './distress-graph';
import { ExpressedSymptomsDetails } from './expressed-symptoms-details';
import { ExpressedSymptomsGraph } from './expressed-symptoms-graph';

const AdministrationResultsPQ16: NextPage = () => {
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

  const expressedSymptoms = Object.entries(response).filter(
    ([, record]) => record.value === 'true'
  );

  const expressedSymptomsCount = expressedSymptoms.length;

  const expressedSymptomsScore = expressedSymptoms
    .map(([, record]) => parseInt(record.score as string) || 0)
    .reduce((acc, score) => acc + score, 0);

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
          <CardTitle>Sintomi espressi</CardTitle>
          <CardDescription>Cut-off = 6</CardDescription>
        </CardHeader>
        <CardContent className="grid grid-cols-[auto,1fr] place-items-center gap-12">
          <p className="w-20 text-lg font-bold text-forest-green-700">
            {expressedSymptomsCount}/16
          </p>
          <ExpressedSymptomsGraph
            expressedSymptomsCount={expressedSymptomsCount}
          />
        </CardContent>
        <CardFooter>
          <Collapsible className="mt-4 grid w-full grid-cols-1">
            <CollapsibleTrigger className="justify-self-end">
              <Maximize2 />
            </CollapsibleTrigger>
            <CollapsibleContent>
              <ExpressedSymptomsDetails expressedSymptoms={expressedSymptoms} />
            </CollapsibleContent>
          </Collapsible>
        </CardFooter>
      </Card>

      <Card className="w-fit">
        <CardHeader>
          <CardTitle>Distress</CardTitle>
          <CardDescription>Cut-off = 8</CardDescription>
        </CardHeader>
        <CardContent className="grid grid-cols-[auto,1fr] place-items-center gap-12">
          <p className="w-20 text-lg font-bold text-forest-green-700">
            {expressedSymptomsScore}/48
          </p>
          <DistressGraph expressedSymptoms={expressedSymptoms} />
        </CardContent>
        <CardFooter>
          <Collapsible className="mt-4 grid w-full grid-cols-1">
            <CollapsibleTrigger className="justify-self-end">
              <Maximize2 />
            </CollapsibleTrigger>
            <CollapsibleContent className="py-4">
              <DistressDetails
                response={response}
                T={currentAdministration.administration.T ?? 0}
              />
            </CollapsibleContent>
          </Collapsible>
        </CardFooter>
      </Card>
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

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
import { type FormValues } from '@/features/questionnaires/eriraos-cl/schema';
import { _default as RootLayout, PatientLayout } from '@/layout';
import { type TView } from '@/types/view-types';
import { api } from '@/utils/api';
import { dateFormatting } from '@/utils/date-formatter';

import {
  type ExpressedSymptoms,
  ExpressedSymptomsDetails,
} from './expressed-symptoms-details';
import { ExpressedSymptomsGraph } from './expressed-symptoms-graph';

const CUT_OFF = 12;

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

  const symptoms = response.items;

  const score = Object.values(symptoms)
    .map((item) => item.value)
    .reduce((acc, item, index) => {
      const multiplier = () => {
        if (index <= 12) return 1;
        if (index >= 13 && index <= 14) return 2;
        return 3;
      };

      switch (item) {
        case 'sì':
          return acc + 2 * multiplier();
        case 'no':
          return acc;
        case 'uncertain':
          return acc + 1 * multiplier();
        default:
          return acc;
      }
    }, 0);

  const expressedSymptoms: ExpressedSymptoms = {
    sì: {
      'last-six-months': [],
      'all-life': [],
    },
    no: {
      'last-six-months': [],
      'all-life': [],
    },
    uncertain: {
      'last-six-months': [],
      'all-life': [],
    },
  };

  Object.entries(symptoms).forEach(([key, item], index) => {
    const value = item.value;

    switch (value) {
      case 'sì':
        return index > 13
          ? expressedSymptoms.sì['all-life'].push(key)
          : expressedSymptoms.sì['last-six-months'].push(key);
      case 'no':
        return index > 13
          ? expressedSymptoms.no['all-life'].push(key)
          : expressedSymptoms.no['last-six-months'].push(key);
      default:
        return index > 13
          ? expressedSymptoms.uncertain['all-life'].push(key)
          : expressedSymptoms.uncertain['last-six-months'].push(key);
    }
  });

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
          <CardDescription>Cut-off = {CUT_OFF}</CardDescription>
        </CardHeader>
        <CardContent className="grid grid-cols-[auto,1fr] place-items-center gap-12">
          <p className="w-20 text-lg font-bold text-forest-green-700">
            {score}/46
          </p>
          <ExpressedSymptomsGraph
            expressedSymptomsCount={score}
            cutOff={CUT_OFF}
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

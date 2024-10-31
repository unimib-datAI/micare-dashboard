import { type NextPage } from 'next';
import { useRouter } from 'next/router';

import { Shimmer } from '@/components/ui/schimmer';
import { AdministrationCardDetail } from '@/features/questionnaires/components/administration-card-detail';
import { type FormValues } from '@/features/questionnaires/ius-r/item';
import { _default as RootLayout, PatientLayout } from '@/layout';
import { type TView } from '@/types/view-types';
import { api } from '@/utils/api';
import { dateFormatting } from '@/utils/date-formatter';

import { DetailsCard } from './details-card';
import { ScoreCard } from './score-card';

const AdministrationResultsIusR: NextPage = () => {
  const router = useRouter();
  const { view } = router.query as { view: TView };
  const [_, administration] = view;

  const avarage = 26.73;
  const standardDeviation = 8.2;

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
  const T = currentAdministration.administration.T ?? 0;

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

      <ScoreCard
        score={score}
        avarage={avarage}
        standardDeviation={standardDeviation}
      />

      <DetailsCard
        response={response}
        avarage={avarage}
        standardDeviation={standardDeviation}
        T={T}
      />
    </div>
  );
};

export default AdministrationResultsIusR;

AdministrationResultsIusR.getLayout = (page) => {
  return (
    <RootLayout>
      <PatientLayout>{page}</PatientLayout>
    </RootLayout>
  );
};

import { type NextPage } from 'next';
import { useRouter } from 'next/router';

import { Shimmer } from '@/components/ui/schimmer';
import { columns } from '@/features/questionnaires/components/table/columns';
import { AdministrationResultsTable } from '@/features/questionnaires/components/table/table';
import { type available } from '@/features/questionnaires/settings';
import { usePatient } from '@/hooks/use-patient';
import { _default as RootLayout, PatientLayout } from '@/layout';

const AdministrationResults: NextPage = () => {
  const { patient, isLoading } = usePatient();
  const router = useRouter();
  const { type } = router.query as { type: (typeof available)[number] };

  return (
    <div className="flex w-1/3 flex-col">
      {isLoading ? (
        <Shimmer className="h-full w-full" />
      ) : (
        <AdministrationResultsTable
          columns={columns}
          data={
            patient?.medicalRecord?.administrations.filter(
              (administration) => administration.type === type
            ) ?? []
          }
          compare
          questionnaire={type}
        />
      )}
    </div>
  );
};

export default AdministrationResults;

AdministrationResults.getLayout = (page) => {
  return (
    <RootLayout>
      <PatientLayout>{page}</PatientLayout>
    </RootLayout>
  );
};

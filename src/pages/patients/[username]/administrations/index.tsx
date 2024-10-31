import { formatDistanceToNow } from 'date-fns';
import { it } from 'date-fns/locale';
import { type NextPage } from 'next';

import { AdministrationCard } from '@/features/questionnaires/components/administration-card';
import { type available } from '@/features/questionnaires/settings';
import { usePatient } from '@/hooks/use-patient';
import { _default as RootLayout, PatientLayout } from '@/layout';

const ADMINISTRATION_TYPES = [
  { name: 'CBA-VE', id: 'cba-ve' },
  { name: 'PQ-16', id: 'pq-16' },
  { name: 'ERIraos-CL', id: 'eriraos-cl' },
  { name: 'GAF/SOFAS', id: 'gaf-sofas' },
  { name: 'GAD-7', id: 'gad-7' },
  { name: 'PSWQ-16', id: 'pswq-16' },
  { name: 'iUS-R', id: 'ius-r' },
  { name: 'DASS-21', id: 'dass-21' },
  { name: 'PDSS', id: 'pdss' },
  { name: 'ASRM', id: 'asrm' },
  { name: 'HCL-32', id: 'hcl-32' },
  { name: 'BHA', id: 'bha' },
  { name: 'HADS', id: 'hads' },
  { name: 'MEC-10', id: 'mec-10' },
  { name: 'EAT-26', id: 'eat-26' },
  { name: 'AEBS', id: 'aebs' },
  { name: 'TEFQ-18', id: 'tefq-18' },
  { name: 'EDE-Q', id: 'ede-q' },
];

const Administrations: NextPage = () => {
  const { patient, isLoading } = usePatient();

  if (isLoading) return null;
  const administrations = patient?.medicalRecord?.administrations;

  return (
    <>
      <main className="flex flex-wrap">
        {ADMINISTRATION_TYPES.map((type) => {
          const administrationOfThisType =
            administrations?.filter(
              (administration) => administration.type === type.id
            ) ?? [];

          const numOfAdministrations = administrationOfThisType.length;

          const getLastAdministration = () => {
            if (numOfAdministrations === 0) return 'Mai';

            const lastAdministration = administrationOfThisType[0]?.date;

            if (!lastAdministration) return 'Mai';

            return formatDistanceToNow(lastAdministration, {
              addSuffix: true,
              locale: it,
            });
          };

          return (
            <AdministrationCard
              key={type.name}
              administrationType={type.name}
              administrationId={type.id as (typeof available)[number]}
              numOfAdministrations={numOfAdministrations}
              lastAdministration={getLastAdministration()}
            />
          );
        })}
      </main>
    </>
  );
};

export default Administrations;

Administrations.getLayout = (page) => {
  return (
    <RootLayout>
      <PatientLayout>{page}</PatientLayout>
    </RootLayout>
  );
};

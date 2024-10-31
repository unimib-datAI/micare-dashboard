import { type NextPage } from 'next';
import dynamic from 'next/dynamic';
import { useRouter } from 'next/router';

import { NewQuestionnaireLoader } from '@/features/questionnaires/components/new-questionnair-loader';
import { AdministrationProvider } from '@/features/questionnaires/context/administration';
import { _default as RootLayout, PatientLayout } from '@/layout';

const getContent = (type: string) => {
  if (!type) return NewQuestionnaireLoader;
  return dynamic(() => import(`@/features/questionnaires/${type}/new`), {
    loading: NewQuestionnaireLoader,
  });
};

const NewAdministration: NextPage = () => {
  const router = useRouter();
  const { type } = router.query as { type: string };
  const Content = getContent(type);
  return (
    <AdministrationProvider>
      <Content />
    </AdministrationProvider>
  );
};

export default NewAdministration;

NewAdministration.getLayout = (page) => {
  return (
    <RootLayout>
      <PatientLayout>{page}</PatientLayout>
    </RootLayout>
  );
};

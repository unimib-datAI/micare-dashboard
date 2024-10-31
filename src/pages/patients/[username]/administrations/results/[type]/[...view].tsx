import { type NextPage } from 'next';
import dynamic from 'next/dynamic';
import { useRouter } from 'next/router';

import { NewQuestionnaireLoader } from '@/features/questionnaires/components/new-questionnair-loader';
import { type available } from '@/features/questionnaires/settings';
import { _default as RootLayout, PatientLayout } from '@/layout';
import { type TView } from '@/types/view-types';

// fare il routing per la visualizzazione dei risultati @see https://nextjs.org/docs/13/pages/building-your-application/routing/dynamic-routes

const getContent = ({
  type,
  view,
}: {
  type: (typeof available)[number];
  view: TView;
}) => {
  if (!type || !view) return NewQuestionnaireLoader;
  const [viewType] = view;
  return dynamic(
    () => import(`@/features/questionnaires/${type}/results/${viewType}`),
    {
      loading: NewQuestionnaireLoader,
    }
  );
};

const ViewAdministration: NextPage = () => {
  const router = useRouter();
  const { type, view } = router.query as {
    type: (typeof available)[number];
    view: TView;
  };
  const Content = getContent({ type, view });
  return <Content />;
};

export default ViewAdministration;

ViewAdministration.getLayout = (page) => {
  return (
    <RootLayout>
      <PatientLayout>{page}</PatientLayout>
    </RootLayout>
  );
};

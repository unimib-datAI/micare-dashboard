import { Header } from '@/features/patient-page/components/header';

type Props = {
  children: React.ReactNode;
};

export const PatientLayout = (props: Props) => {
  const { children } = props;

  return (
    <div className="relative min-h-full p-3">
      <Header />
      <main className="mt-3">{children}</main>
    </div>
  );
};

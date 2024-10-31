import { AlertCircle, Plus } from 'lucide-react';
import { type NextPage } from 'next';
import { useContext } from 'react';

import { Alert, AlertDescription, AlertTitle } from '@/components/ui/alert';
import { Button } from '@/components/ui/button';
import { RootContainerRefContext } from '@/context';
import { Dialog } from '@/features/add-patient';
import { columns, PatientsTable } from '@/features/patients-table';
import { useUser } from '@/hooks/use-user';

const Home: NextPage = () => {
  const { user, isLoading } = useUser();
  const containerRef = useContext(RootContainerRefContext);
  if (isLoading || !user) return null;

  const hasPatients = user?.patients?.length > 0;

  return (
    <main className="relative min-h-full p-3">
      {hasPatients ? (
        <PatientsTable
          columns={columns}
          data={user.patients}
          containerRef={containerRef}
        />
      ) : (
        <div className="relative grid min-h-screen-safe place-items-center">
          <Alert className="w-80 py-6 pr-6">
            <AlertCircle className="mt-1.5 h-5 w-5 text-forest-green-700" />
            <AlertTitle className="text-forest-green-700">
              Attenzione!
            </AlertTitle>
            <AlertDescription className="mb-4">
              Al momento non hai registrato ancora nessun paziente. Inizia
              aggiungendo il tuo primo paziente
            </AlertDescription>
            <Dialog
              containerRef={containerRef}
              trigger={
                <Button>
                  <Plus className="h-4 w-4" />
                  <small className="px-3">Aggiungi paziente</small>
                </Button>
              }
            />
          </Alert>
        </div>
      )}
    </main>
  );
};

export default Home;

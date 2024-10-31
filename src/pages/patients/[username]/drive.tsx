import { type NextPage } from 'next';
import Image from 'next/image';

import { _default as RootLayout, PatientLayout } from '@/layout';

const Drive: NextPage = () => {
  return (
    <>
      <main className="grid h-full">
        <h1 className="font-h1">Pagina dei materiali</h1>
        <p>
          L&apos;immagine che segue è un esempio di come sarà la pagina
          materiali una volta completata.
        </p>
        <Image
          className="mt-4 rounded-xl border-2 border-forest-green-700"
          src="/images/drive-example-placeholder.png"
          alt="Pagina dei materiali"
          width={1466}
          height={758}
        />
      </main>
    </>
  );
};

export default Drive;

Drive.getLayout = (page) => {
  return (
    <RootLayout>
      <PatientLayout>{page}</PatientLayout>
    </RootLayout>
  );
};

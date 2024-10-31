import { type NextPage } from 'next';
import Image from 'next/image';

import { _default as RootLayout, PatientLayout } from '@/layout';

const Diaries: NextPage = () => {
  return (
    <>
      <main className="grid h-full">
        <h1 className="font-h1">Pagina dei diari</h1>
        <p>
          L&apos;immagine che segue è un esempio di come sarà la pagina diari
          una volta completata.
        </p>
        <Image
          className="mt-4 rounded-xl border-2 border-forest-green-700"
          src="/images/diaries-example-placeholder.png"
          alt="Pagina dei materiali"
          width={1166}
          height={448}
        />
        <ul>
          <li>
            <a href="https://coney.cefriel.com/app/chat/?d=T6QexsICi1QxzG21-ZDakSOzqbt9m_3xdJLV6L3E8VrQsmSDu8JuEXVvjKNBMwV4fR-OO1JUPpUi2GLo6RobWQ==">
              Demo diario cognitivo-comportamentale
            </a>
          </li>
          <li>
            <a href="https://coney.cefriel.com/app/chat/?d=T6QexsICi1QxzG21-ZDakbGLRl9KFuxS2HAGtYWq217IeNOCxrN8F5pMZqJgdyc50wxrB16gxKLqn39UkEXvVQ==">
              Demo diario solo cognitivo
            </a>
          </li>
          <li>
            <a href="https://coney.cefriel.com/app/chat/?d=T6QexsICi1QxzG21-ZDakTawvyKAKchAkIDZ7O69NbkUDi5yUdw3fKSyMo96epRnbMLe9ro7dtmKOZaOUvhjig==">
              Demo diario solo comportamentale
            </a>
          </li>
        </ul>
      </main>
    </>
  );
};

export default Diaries;

Diaries.getLayout = (page) => {
  return (
    <RootLayout>
      <PatientLayout>{page}</PatientLayout>
    </RootLayout>
  );
};

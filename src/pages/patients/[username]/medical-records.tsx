import { LayoutGroup, motion, type Variants } from 'framer-motion';
import { type NextPage } from 'next';
import { useState } from 'react';

import { AnamnesticData } from '@/features/medical-records/components/anamnestic-data';
import { ClinicalData } from '@/features/medical-records/components/clinical-data';
import { Intervention } from '@/features/medical-records/components/intervention';
import { MedicalRecordsContext } from '@/features/medical-records/contexts/medical-records';
import { _default as RootLayout, PatientLayout } from '@/layout';
import { cn } from '@/utils/cn';

const variants: Variants = {
  selected: {
    position: 'absolute',
    inset: 0,
    zIndex: 20,
    scale: 1,
  },
  unselected: {
    position: 'relative',
    zIndex: 0,
    scale: 1,
  },
};

const MedicalRecords: NextPage = () => {
  const [selected, setSelected] = useState<string | null>(null);

  return (
    <div className="flex flex-col items-center gap-3">
      <MedicalRecordsContext.Provider
        value={{ selected, setSelected, variants }}
      >
        <LayoutGroup>
          <AnamnesticData />
          <ClinicalData />
          <Intervention />
        </LayoutGroup>
      </MedicalRecordsContext.Provider>
      <motion.div
        initial={{ opacity: 0 }}
        animate={{ opacity: selected ? 1 : 0 }}
        transition={{ duration: 0.2 }}
        exit={{ opacity: 0 }}
        className={cn(
          selected &&
            'absolute inset-0 z-10 flex h-full w-full place-content-center place-items-center bg-black bg-opacity-50 p-8'
        )}
      />
    </div>
  );
};

export default MedicalRecords;

MedicalRecords.getLayout = (page) => {
  return (
    <RootLayout>
      <PatientLayout>{page}</PatientLayout>
    </RootLayout>
  );
};

import type { Variants } from 'framer-motion';
import { createContext, type Dispatch, type SetStateAction } from 'react';

type MedicalRecordsContextType = {
  selected: string | null;
  setSelected: Dispatch<SetStateAction<string | null>>;
  variants: Variants;
};

export const MedicalRecordsContext = createContext<MedicalRecordsContextType>({
  selected: null,
  setSelected: (arg) => void arg,
  variants: {},
});

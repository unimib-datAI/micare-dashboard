import { type DetailedHTMLProps, type HTMLAttributes } from 'react';
import { createContext } from 'react';

import { cn } from '@/utils/cn';

type WizardContext = {
  currentStep: number;
  totalStep: number;
};

export const WizardContext = createContext<WizardContext>({
  currentStep: 0,
  totalStep: 0,
});

type Props = {
  children: React.ReactNode;
  currentStep: number;
  totalStep: number;
} & DetailedHTMLProps<HTMLAttributes<HTMLDivElement>, HTMLDivElement>;

export const Wizard = ({
  className,
  children,
  currentStep,
  totalStep,
  ...props
}: Props) => (
  <WizardContext.Provider value={{ currentStep, totalStep }}>
    <div {...props} className={cn('h-full', className)}>
      {children}
    </div>
  </WizardContext.Provider>
);

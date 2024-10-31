import { type DetailedHTMLProps, type HTMLAttributes, useContext } from 'react';

import { cn } from '@/utils/cn';

import { WizardContext } from './wizard';

type Props = {
  children: React.ReactNode;
} & DetailedHTMLProps<HTMLAttributes<HTMLDivElement>, HTMLDivElement>;

export const WizardStepper = ({ className, children, ...props }: Props) => {
  const { totalStep } = useContext(WizardContext);
  return (
    <div
      {...props}
      className={cn('mx-auto w-full max-w-2xl rounded-2xl bg-white', className)}
    >
      <div
        className={`grid rounded`}
        style={{ gridTemplateColumns: `repeat(${totalStep}, 1fr)` }}
      >
        {children}
      </div>
    </div>
  );
};

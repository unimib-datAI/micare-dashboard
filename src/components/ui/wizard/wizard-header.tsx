import { type DetailedHTMLProps, type HTMLAttributes } from 'react';

import { cn } from '@/utils/cn';

type Props = {
  children: React.ReactNode;
} & DetailedHTMLProps<HTMLAttributes<HTMLDivElement>, HTMLDivElement>;

export const WizardHeader = ({ className, children, ...props }: Props) => {
  return (
    <div {...props} className={cn('flex flex-col gap-2', className)}>
      {children}
    </div>
  );
};

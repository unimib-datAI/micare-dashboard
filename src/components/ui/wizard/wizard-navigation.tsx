import { type DetailedHTMLProps, type HTMLAttributes } from 'react';

import { cn } from '@/utils/cn';

type Props = {
  children?: React.ReactNode;
} & DetailedHTMLProps<HTMLAttributes<HTMLDivElement>, HTMLDivElement>;

export const WizardNavigation = (props: Props) => {
  const { className, children, ...rest } = props;

  return (
    <div
      className={cn(
        'mx-auto mt-auto flex w-full max-w-xl justify-between',
        className
      )}
      {...rest}
    >
      {children}
    </div>
  );
};

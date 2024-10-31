import { cva, type VariantProps } from 'class-variance-authority';
import { useRef } from 'react';

import { ScrollIndicator } from '@/components/ui/scroll-indicator';
import { cn } from '@/utils/cn';

type Props = {
  children: React.ReactNode;
  title?: string;
  description?: string;
} & React.HTMLAttributes<HTMLDivElement> &
  VariantProps<typeof wrapperVariants>;

const wrapperVariants = cva('', {
  variants: {
    variant: {
      single: 'mb-4 flex flex-col gap-4',
      double: 'grid grid-cols-2 gap-x-8 gap-y-4',
      quadruple: 'grid grid-cols-4 gap-x-8 gap-y-4',
    },
  },
  defaultVariants: {
    variant: 'double',
  },
});

export const StepWrapper = (props: Props) => {
  const { children, className, title, description, variant } = props;

  const ref = useRef<HTMLDivElement>(null);

  return (
    <div
      className={cn(
        'relative h-full w-full shrink-0 grow-0 basis-auto',
        className
      )}
    >
      <div ref={ref} className="scrollbar-hide h-full overflow-y-auto">
        <ScrollIndicator container={ref} />
        <div className="mx-auto flex max-w-xl flex-col gap-4">
          <header className="mb-3">
            <h2 className="font-h2">{title}</h2>
            <p className="font-default">{description}</p>
          </header>
          <div className={cn(wrapperVariants({ variant }))}>{children}</div>
        </div>
      </div>
    </div>
  );
};

import { cva, type VariantProps } from 'class-variance-authority';
import { type LucideIcon } from 'lucide-react';
import { type HTMLAttributes } from 'react';

import { cn } from '@/utils/cn';

interface DataTitleProps {
  label: string;
  Icon: LucideIcon;
}

export const DataTitle = (props: DataTitleProps) => {
  const { label, Icon } = props;

  return (
    <div className="flex flex-row items-center gap-1 text-sm text-slate-400">
      <Icon className="h-4 w-4" />
      <span>{label}</span>
    </div>
  );
};

interface DataContentProps extends HTMLAttributes<HTMLParagraphElement> {
  children: React.ReactNode;
}
export const DataContent = ({ children, className }: DataContentProps) => {
  return <div className={cn('text-space-gray', className)}>{children}</div>;
};

DataContent.displayName = 'DataContent';

const wrapperVariants = cva('text-space-gray text-sm ml-2 px-1', {
  variants: {
    type: {
      default: 'whitespace-pre-line inline-block break-all w-full',
      long: 'px-1 ml-4 grid-cols-[repeat(1,_max-content)]',
    },
  },
  defaultVariants: {
    type: 'default',
  },
});

interface DataWrapperProps
  extends HTMLAttributes<HTMLParagraphElement>,
    VariantProps<typeof wrapperVariants> {
  label: string;
  Icon: LucideIcon;
  children: React.ReactNode;
  editable?: boolean;
}
export const DataWrapper = (props: DataWrapperProps) => {
  const { label, Icon, type, className, children } = props;
  return (
    <>
      <DataTitle label={label} Icon={Icon} />
      <DataContent
        {...props}
        className={cn(wrapperVariants({ type, className }))}
      >
        {children}
      </DataContent>
    </>
  );
};

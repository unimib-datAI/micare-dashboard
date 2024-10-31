import { cva, type VariantProps } from 'class-variance-authority';
import * as React from 'react';

import {
  type PolymorphicComponentPropWithRef,
  type PolymorphicRef,
} from '@/types/polymorphic-types';
import { cn } from '@/utils/cn';

const buttonVariants = cva(
  'inline-flex items-center justify-center rounded-md font-button focus:outline-none disabled:opacity-50 disabled:pointer-events-none data-[state=open]:bg-slate-100 transition-colors duration-300',
  {
    variants: {
      variant: {
        default: 'bg-forest-green-700 text-white hover:bg-forest-green-600',
        outline:
          'bg-transparent border-2 forest-green-700 hover:bg-forest-green-300 text-forest-green-700 hover:text-white hover:border-forest-green-300',
        danger: 'bg-red-500 text-white hover:bg-red-400',
        ghost: 'text-space-gray hover:bg-forest-green-700/10',
        link: 'underline-offset-4 hover:underline text-forest-green-700',
        'with-icon-right': 'pl-4 pr-2',
        'with-icon-left': 'pl-2 pr-4',
      },
      size: {
        default: 'h-10 py-2 px-4',
        sm: 'h-9 px-2 rounded-md',
        lg: 'h-11 px-8 rounded-md',
        icon: 'h-auto rounded-full p-2',
        auto: 'h-auto px-4 py-2',
      },
      icon: {
        default: '',
        only: 'p-0',
        left: 'pl-2',
        right: 'pr-2',
      },
      isDisabled: {
        true: 'opacity-50 pointer-events-none',
      },
    },
    defaultVariants: {
      variant: 'default',
      size: 'default',
      icon: 'default',
    },
  }
);

type ButtonProps<C extends React.ElementType> = PolymorphicComponentPropWithRef<
  C,
  VariantProps<typeof buttonVariants>
>;

type ButtonComponent = <C extends React.ElementType = 'button'>(
  props: ButtonProps<C>
) => React.ReactNode;

// eslint-disable-next-line react/display-name
const Button: ButtonComponent = React.forwardRef(
  <C extends React.ElementType = 'button'>(
    props: ButtonProps<C>,
    ref?: PolymorphicRef<C>
  ) => {
    const {
      as = 'button',
      children,
      className,
      variant,
      size,
      icon,
      isDisabled,
      ...rest
    } = props;
    const Component = as;

    return (
      <Component
        {...rest}
        className={cn(
          buttonVariants({ variant, size, icon, isDisabled, className })
        )}
        ref={ref}
      >
        {children}
      </Component>
    );
  }
);

export { Button, buttonVariants };

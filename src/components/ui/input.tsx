import { AnimatePresence, motion } from 'framer-motion';
import { type LucideIcon, Upload } from 'lucide-react';
import Image from 'next/image';
import {
  forwardRef,
  type HTMLInputTypeAttribute,
  type TextareaHTMLAttributes,
  useState,
} from 'react';
import { type DayPickerSingleProps } from 'react-day-picker';
import { type FieldError } from 'react-hook-form';

import useInputFile from '@/hooks/use-input-file';
import { cn } from '@/utils/cn';

import { DatePicker } from './date-picker';

interface ExtendInput extends React.InputHTMLAttributes<HTMLInputElement> {
  type: HTMLInputTypeAttribute | 'textArea';
}

type InputDateProps = DayPickerSingleProps & { tabIndex?: number };

export type InputProps = ExtendInput &
  TextareaHTMLAttributes<HTMLTextAreaElement> &
  Partial<DayPickerSingleProps> & {
    image?: boolean;
    textArea?: boolean;
    label?: string;
    labelClassName?: string;
    containerClassName?: string;
    helperText?: string;
    error?: FieldError;
    IconLeft?: LucideIcon;
    IconRight?: LucideIcon;
    labelVariant?: 'default' | 'del';
    labelAltText?: string;
  };

const ImageInput = forwardRef<HTMLInputElement, InputProps>(
  (props: InputProps, ref) => {
    const { label, labelClassName, helperText } = props;

    const [filePath, setFilePath] = useState<string | undefined>(undefined);

    const handleFileChange = (e: Event) => {
      if (!e.currentTarget) return;
      const file = (e.currentTarget as HTMLInputElement).files?.[0];

      if (!file) return;
      const objectUrl = URL.createObjectURL(file);
      setFilePath(objectUrl);
    };

    useInputFile({
      ref: (ref as React.RefObject<HTMLInputElement>) ?? undefined,
      onChange: handleFileChange,
      options: {
        accept: 'image/.png, image/.jpg, image/.jpeg, image/.webp',
      },
    });

    return (
      <>
        {label && (
          <span
            className={cn('font-default block text-space-gray', labelClassName)}
          >
            {label}
          </span>
        )}
        <div className="flex w-full items-center justify-between gap-4">
          <div className="relative mt-2 aspect-square h-32 w-32">
            <Image
              className="rounded-full border border-forest-green-700 object-cover"
              src={
                filePath ??
                'data:image/gif;base64,R0lGODlhAQABAAD/ACwAAAAAAQABAAACADs='
              }
              fill
              alt=""
            />
            <label
              htmlFor="image"
              className="absolute bottom-0 right-0 rounded-full bg-forest-green-700 p-3"
            >
              <Upload className="cursor-pointer text-white" />
              <input
                {...props}
                id="image"
                ref={ref}
                type="file"
                className="hidden"
              />
            </label>
          </div>
          {helperText && (
            <p className="font-small whitespace-pre-line text-center text-slate-500">
              {helperText}
            </p>
          )}
        </div>
      </>
    );
  }
);
ImageInput.displayName = 'ImageInput';

const TextAreaInput = forwardRef<HTMLTextAreaElement, InputProps>(
  (props: InputProps, ref) => {
    const {
      id,
      label,
      labelClassName,
      containerClassName,
      className,
      helperText,
      error,
      ...rest
    } = props;
    return (
      <InputLabel
        id={id}
        label={label}
        labelClassName={labelClassName}
        containerClassName={containerClassName}
        helperText={helperText}
        error={error}
      >
        <textarea
          {...rest}
          ref={ref}
          className={cn(
            'font-default w-full rounded-lg border border-forest-green-700 bg-gray-10 p-2.5 text-space-gray placeholder-gray-500 focus:ring-forest-green-700 disabled:cursor-not-allowed disabled:opacity-50',
            className
          )}
        />
      </InputLabel>
    );
  }
);
TextAreaInput.displayName = 'TextAreaInput';

const DateInput = (props: InputProps) => {
  const {
    id,
    label,
    labelClassName,
    containerClassName,
    helperText,
    error,
    ...rest
  } = props;

  return (
    <InputLabel
      id={id}
      label={label}
      labelClassName={labelClassName}
      containerClassName={containerClassName}
      helperText={helperText}
      error={error}
    >
      <DatePicker {...(rest as InputDateProps)} />
    </InputLabel>
  );
};

type InputLabelProps = {
  id?: string;
  label?: string;
  labelClassName?: string;
  containerClassName?: string;
  helperText?: string;
  error?: FieldError;
  children: React.ReactNode;
  IconLeft?: LucideIcon;
  IconRight?: LucideIcon;
  labelVariant?: 'default' | 'del';
  labelAltText?: string;
};

const InputLabel = (props: InputLabelProps) => {
  const {
    label,
    labelClassName,
    containerClassName,
    helperText,
    error,
    IconLeft,
    IconRight,
    children,
    labelVariant,
    labelAltText,
  } = props;

  return (
    <div className={cn('relative', containerClassName)}>
      {label && (
        <label
          htmlFor={props.id}
          className={cn(
            'font-default mb-2 block text-space-gray',
            labelClassName
          )}
        >
          {(labelVariant === 'del' && (
            <span>
              <del>{label}</del> <ins>{labelAltText}</ins>
            </span>
          )) ||
            label}
        </label>
      )}
      {IconLeft && (
        <IconLeft
          size={20}
          className="absolute left-2.5 top-2.5 text-forest-green-700"
        />
      )}
      {children}
      {IconRight && (
        <IconRight
          size={20}
          className="absolute right-2.5 top-2.5 text-forest-green-700"
        />
      )}
      <AnimatePresence mode="wait">
        <motion.p
          key={error?.message || helperText}
          initial={{ y: -10, opacity: 0 }}
          animate={{ y: 0, opacity: 1 }}
          exit={{ y: 10, opacity: 0 }}
          transition={{ duration: 0.2 }}
          className={cn(
            'font-small text-slate-500',
            !!error && 'mt-1',
            !!error && error.type !== 'CredentialsError' ? 'text-red-500' : ''
          )}
        >
          {error?.message || helperText}
        </motion.p>
      </AnimatePresence>
    </div>
  );
};

export const Input = forwardRef<unknown, InputProps>(
  (props: InputProps, ref) => {
    const {
      className,
      type,
      id,
      label,
      labelClassName,
      labelVariant = 'default',
      labelAltText,
      containerClassName,
      helperText,
      error,
      IconLeft,
      IconRight,
      ...rest
    } = props;

    if (type === 'image')
      return (
        <ImageInput {...props} ref={ref as React.RefObject<HTMLInputElement>} />
      );

    if (type === 'textArea')
      return (
        <TextAreaInput
          {...props}
          ref={ref as React.RefObject<HTMLTextAreaElement>}
        />
      );

    if (type === 'date') return <DateInput {...props} />;

    return (
      <InputLabel
        id={id}
        label={label}
        labelClassName={labelClassName}
        labelVariant={labelVariant}
        labelAltText={labelAltText}
        containerClassName={containerClassName}
        helperText={helperText}
        error={error}
        IconLeft={IconLeft}
        IconRight={IconRight}
      >
        <input
          {...rest}
          ref={ref as React.RefObject<HTMLInputElement>}
          type={type}
          className={cn(
            'font-default block min-h-[2.5rem] w-full rounded-lg border border-forest-green-700 bg-gray-10 px-2.5 text-space-gray placeholder-gray-500 outline-forest-green-700 focus:ring-forest-green-700 focus-visible:ring-forest-green-700 disabled:cursor-not-allowed disabled:opacity-50',
            IconRight && 'pr-10',
            IconLeft && 'pl-10',
            className
          )}
        />
      </InputLabel>
    );
  }
);
Input.displayName = 'Input';

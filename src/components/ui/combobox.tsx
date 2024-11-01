'use client';

import { Check, ChevronsUpDown, Filter, type LucideIcon } from 'lucide-react';
import * as React from 'react';

import { Button } from '@/components/ui/button';
import {
  Command,
  CommandEmpty,
  CommandGroup,
  CommandInput,
  CommandItem,
  CommandList,
} from '@/components/ui/command';
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from '@/components/ui/popover';
import { cn } from '@/utils/cn';

export type Options = {
  value: string;
  label: string;
  icon?: LucideIcon;
};

type ComboboxProps = {
  options: Options[];
  emptyText: string;
  placeholder: string;
  label: string;
  value?: string;
  setValue: (value: string) => void;
  triggerClassName?: string;
  itemClassName?: string;
  containerClassName?: string;
  triggerText?: string;
};

export const Combobox = (props: ComboboxProps) => {
  const {
    options,
    emptyText,
    placeholder,
    label,
    value,
    setValue,
    triggerClassName,
    itemClassName,
    containerClassName,
    triggerText,
  } = props;

  const [open, setOpen] = React.useState(false);
  const handleOnSelect = (currentValue: string) => {
    setValue(currentValue === value ? '' : currentValue);
    setOpen(false);
  };

  return (
    <Popover open={open} onOpenChange={setOpen}>
      <PopoverTrigger asChild>
        <Button
          variant="outline"
          role="combobox"
          aria-expanded={open}
          className={cn(
            'flex w-[260px] items-center justify-between rounded-md border border-forest-green-700 bg-gray-10 p-2.5 text-gray-500 hover:bg-white focus:ring-forest-green-700 disabled:cursor-not-allowed disabled:opacity-50',
            triggerClassName
          )}
        >
          {value ? (
            triggerText ? (
              triggerText
            ) : (
              <span className="text-space-gray">
                {options.find((option) => option.value === value)?.label}
              </span>
            )
          ) : (
            label
          )}
          <ChevronsUpDown className="ml-2 h-4 w-4 shrink-0 opacity-50" />
        </Button>
      </PopoverTrigger>
      <PopoverContent className={cn('w-[260px] p-0', containerClassName)}>
        <Command>
          <CommandInput placeholder={placeholder} className="text-space-gray" />
          <CommandEmpty>{emptyText}.</CommandEmpty>
          <CommandGroup>
            {options.map((option) => (
              <CommandItem
                className={cn(
                  'focus:bg-accent focus:text-accent-foreground font-default relative flex w-full cursor-pointer select-none items-center justify-between rounded-md px-2.5 py-1.5 text-sm text-gray-500 outline-none transition-colors hover:bg-slate-200 data-[disabled]:pointer-events-none data-[disabled]:opacity-50',
                  value === option.value &&
                    'bg-forest-green-200 hover:bg-slate-200',
                  itemClassName
                )}
                key={option.value}
                onSelect={handleOnSelect}
              >
                {option.label}
                <Check
                  className={cn(
                    'mr-2 h-4 w-4',
                    value === option.value ? 'opacity-100' : 'opacity-0'
                  )}
                />
              </CommandItem>
            ))}
          </CommandGroup>
        </Command>
      </PopoverContent>
    </Popover>
  );
};

export function ComboboxPopover(props: ComboboxProps) {
  const {
    options,
    emptyText,
    placeholder,
    label,
    value,
    setValue,
    triggerClassName,
    containerClassName,
    itemClassName,
    triggerText,
  } = props;

  const [open, setOpen] = React.useState(false);

  const getSelectedOption = (value: string | undefined) => {
    return options.find((option) => option.value === value);
  };

  const selectedStatus = getSelectedOption(value);

  const handleOnSelect = (currentValue: string) => {
    setValue(currentValue === value ? '' : currentValue);
    setOpen(false);
  };

  return (
    <Popover open={open} onOpenChange={setOpen}>
      <PopoverTrigger asChild>
        <Button
          variant="with-icon-right"
          size="sm"
          className={triggerClassName}
        >
          {selectedStatus ? (
            triggerText ? (
              triggerText
            ) : (
              <>
                {selectedStatus.icon && (
                  <selectedStatus.icon className="mr-2 h-4 w-4 shrink-0" />
                )}
                {selectedStatus.label}
              </>
            )
          ) : (
            <>{label}</>
          )}
          <Filter
            className="ml-2 h-4 w-4 shrink-0"
            fill={selectedStatus ? 'currentColor' : 'none'}
          />
        </Button>
      </PopoverTrigger>
      <PopoverContent
        className={cn('p-0', containerClassName)}
        side="right"
        align="start"
      >
        <Command>
          <CommandInput placeholder={placeholder} />
          <CommandList>
            <CommandEmpty>{emptyText}.</CommandEmpty>
            <CommandGroup>
              {options.map((option) => (
                <CommandItem
                  key={option.value}
                  onSelect={handleOnSelect}
                  className={cn(
                    'focus:bg-accent focus:text-accent-foreground font-default relative flex w-full cursor-pointer select-none items-center justify-between rounded-md px-2.5 py-1.5 text-sm text-gray-500 outline-none transition-colors hover:bg-slate-200 data-[disabled]:pointer-events-none data-[disabled]:opacity-50',
                    value === option.value &&
                      'bg-forest-green-200 hover:bg-slate-200',
                    itemClassName
                  )}
                >
                  {option.icon && (
                    <option.icon
                      className={cn(
                        'mr-2 h-4 w-4',
                        option.value === selectedStatus?.value
                          ? 'opacity-100'
                          : 'opacity-40'
                      )}
                    />
                  )}
                  <span>{option.label}</span>
                  <Check
                    className={cn(
                      'mr-2 h-4 w-4',
                      value === option.value ? 'opacity-100' : 'opacity-0'
                    )}
                  />
                </CommandItem>
              ))}
            </CommandGroup>
          </CommandList>
        </Command>
      </PopoverContent>
    </Popover>
  );
}

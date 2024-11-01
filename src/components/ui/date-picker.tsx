'use client';

import { format } from 'date-fns';
import { it } from 'date-fns/locale';
import { Calendar as CalendarIcon } from 'lucide-react';
import * as React from 'react';
import { type DayPickerSingleProps } from 'react-day-picker';

import { Button } from '@/components/ui/button';
import { Calendar } from '@/components/ui/calendar';
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from '@/components/ui/popover';
import { cn } from '@/utils/cn';

export type InputProps = DayPickerSingleProps & { tabIndex?: number };

export const DatePicker = (props: InputProps) => {
  const { className, selected, onSelect, tabIndex } = props;

  return (
    <Popover>
      <PopoverTrigger asChild>
        <Button
          variant={'outline'}
          size="auto"
          tabIndex={tabIndex}
          className={cn(
            'font-default flex min-h-[2.5rem] w-full items-center justify-between rounded-md border border-forest-green-700 bg-gray-10 px-2.5 py-0 text-space-gray hover:bg-white hover:text-slate-200 focus:ring-forest-green-700 disabled:cursor-not-allowed disabled:opacity-50 data-[state=open]:bg-gray-10',
            !selected && 'text-muted-foreground',
            className
          )}
        >
          {selected ? (
            format(selected, 'PPP', { locale: it })
          ) : (
            <span>Seleziona una data</span>
          )}
          <CalendarIcon className="h-4 w-4" />
        </Button>
      </PopoverTrigger>
      <PopoverContent className="font-default relative z-50 w-auto overflow-hidden rounded-md border border-forest-green-700 bg-gray-10 p-0 text-popover-foreground animate-in fade-in-80">
        <Calendar
          mode="single"
          selected={selected}
          onSelect={onSelect}
          locale={it}
          initialFocus
        />
      </PopoverContent>
    </Popover>
  );
};

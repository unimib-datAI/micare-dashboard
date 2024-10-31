import { type Table } from '@tanstack/react-table';
import { Plus, Search } from 'lucide-react';

import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Dialog } from '@/features/add-patient';

interface FilterBarProps<TData> {
  table: Table<TData>;
  containerRef: React.RefObject<HTMLDivElement>;
}

export const FilterBar = <TData,>(props: FilterBarProps<TData>) => {
  const { table, containerRef } = props;

  return (
    <section className="relative flex items-center justify-between pb-4">
      <Input
        placeholder="Cerca paziente"
        type="text"
        value={(table.getColumn('name')?.getFilterValue() as string) ?? ''}
        onChange={(event) =>
          table.getColumn('name')?.setFilterValue(event.target.value)
        }
        className="max-w-sm"
        IconRight={Search}
      />

      <Dialog
        containerRef={containerRef}
        trigger={
          <Button>
            <span className="px-3">Aggiungi paziente</span>
            <Plus />
          </Button>
        }
      />
    </section>
  );
};

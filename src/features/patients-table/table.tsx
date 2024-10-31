import {
  type ColumnDef,
  type ColumnFiltersState,
  type FilterFn,
  getCoreRowModel,
  getFilteredRowModel,
  getPaginationRowModel,
  getSortedRowModel,
  type SortingState,
  useReactTable,
  type VisibilityState,
} from '@tanstack/react-table';
import { useState } from 'react';

import { Table, TablePagination } from '@/components/ui/table';

import { FilterBar } from './filter-bar';
import { TableBody } from './table-body';
import { TableHeader } from './table-header';
import { fuzzyFilter } from './utils/filterFns';

interface TableProps<TData, TValue> {
  columns: ColumnDef<TData, TValue>[];
  data: TData[];
  containerRef: React.RefObject<HTMLDivElement>;
}

declare module '@tanstack/react-table' {
  interface FilterFns {
    fuzzy: FilterFn<unknown>;
  }
}

export const PatientsTable = <TData, TValue>({
  columns,
  data,
  containerRef,
}: TableProps<TData, TValue>) => {
  const [sorting, setSorting] = useState<SortingState>([
    { id: 'name', desc: true },
  ]);
  const [columnFilters, setColumnFilters] = useState<ColumnFiltersState>([]);
  const [columnVisibility, setColumnVisibility] = useState<VisibilityState>({
    etichetta: false,
  });

  const table = useReactTable({
    filterFns: {
      fuzzy: fuzzyFilter,
    },
    columns,
    data,
    getCoreRowModel: getCoreRowModel(),
    getPaginationRowModel: getPaginationRowModel(),
    onSortingChange: setSorting,
    getSortedRowModel: getSortedRowModel(),
    onColumnFiltersChange: setColumnFilters,
    getFilteredRowModel: getFilteredRowModel(),
    onColumnVisibilityChange: setColumnVisibility,
    state: {
      sorting,
      columnFilters,
      columnVisibility,
    },
  });

  return (
    <div className="flex h-screen-safe flex-col">
      <FilterBar table={table} containerRef={containerRef} />
      <div className="mb-4 max-h-full overflow-auto rounded-md border">
        <Table className="w-full table-fixed">
          <TableHeader table={table} />
          <TableBody table={table} />
        </Table>
      </div>
      <TablePagination
        side="top"
        table={table}
        subject="pazienti"
        className="mt-auto"
      />
    </div>
  );
};

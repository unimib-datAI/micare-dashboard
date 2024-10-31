import {
  type ColumnDef,
  type FilterFn,
  getCoreRowModel,
  getPaginationRowModel,
  getSortedRowModel,
  type SortingState,
  useReactTable,
} from '@tanstack/react-table';
import Link from 'next/link';
import { useRouter } from 'next/router';
import { useState } from 'react';

import { Button } from '@/components/ui/button';
import { Table } from '@/components/ui/table';
import { type available } from '@/features/questionnaires/settings';

import { AdministrationTableBody } from './table-body';
import { AdministrationTableHeader } from './table-header';
import { dateFilter } from './utils/filterFns';

interface TableProps<TData, TValue> {
  columns: ColumnDef<TData, TValue>[];
  data: TData[];
  compare?: boolean;
  questionnaire: (typeof available)[number];
}

declare module '@tanstack/react-table' {
  interface FilterFns {
    fuzzy: FilterFn<unknown>;
  }
}

export const AdministrationResultsTable = <TData, TValue>({
  columns,
  data,
  compare = false,
  questionnaire,
}: TableProps<TData, TValue>) => {
  const router = useRouter();
  const { username } = router.query as { username: string };
  const goToCompare = `/patients/${username}/administrations/results/${questionnaire}/compare`;
  const [rowSelection, setRowSelection] = useState<{ [_: number]: boolean }>(
    {}
  );
  const [sorting, setSorting] = useState<SortingState>([
    { id: 'date', desc: true },
  ]);

  type TDataExtended = TData & { id: string };

  const getAdministrationIDs = (
    rowsSelected: { [_: number]: boolean },
    data: TDataExtended[]
  ): string[] => {
    const rowIds = Object.keys(rowsSelected).map((id) => parseInt(id));
    const [t0, t1] = rowIds;
    if (t0 === undefined || t1 === undefined) return [];

    const t0Id = data[t0];
    const t1Id = data[t1];
    if (t0Id === undefined || t1Id === undefined) return [];

    return [t0Id.id, t1Id.id];
  };

  const table = useReactTable({
    filterFns: {
      fuzzy: dateFilter,
    },
    columns,
    data,
    getCoreRowModel: getCoreRowModel(),
    getPaginationRowModel: getPaginationRowModel(),
    onSortingChange: setSorting,
    getSortedRowModel: getSortedRowModel(),
    state: {
      rowSelection,
      sorting,
    },
    onRowSelectionChange: setRowSelection,
  });

  const selected = table.getSelectedRowModel().rows.length;

  return (
    <>
      <div className="flex flex-col overflow-hidden rounded-md border ">
        <Table className="w-full table-fixed">
          <AdministrationTableBody table={table} />
          <AdministrationTableHeader table={table} />
        </Table>
        {compare && (
          <div className="mt-4 flex items-center justify-end gap-4 pb-4 pr-4">
            <p className="text-sm text-gray-500">
              {selected} di 2 somministrazioni selezionate
            </p>

            <Button
              as={Link}
              href={{
                pathname: goToCompare,
                query: {
                  comparison: getAdministrationIDs(
                    rowSelection,
                    data as TDataExtended[]
                  ),
                },
              }}
              isDisabled={Object.keys(rowSelection).length !== 2}
              size="sm"
              className="text-sm"
            >
              Confronta
            </Button>
          </div>
        )}
      </div>
    </>
  );
};

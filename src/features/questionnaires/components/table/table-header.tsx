import { flexRender, type Table } from '@tanstack/react-table';

import {
  TableHead,
  TableHeader as THeader,
  TableRow,
} from '@/components/ui/table';

import { getSize } from './utils/get-column-size';

interface TableHeaderProps<TData> {
  table: Table<TData>;
}

export const AdministrationTableHeader = <TData,>(
  props: TableHeaderProps<TData>
) => {
  const { table } = props;

  return (
    <THeader className="bg-forest-green-700 text-sm text-white">
      {table.getHeaderGroups().map((headerGroup) => (
        <TableRow key={headerGroup.id}>
          {headerGroup.headers.map((header) => {
            return (
              <TableHead
                key={header.id}
                className={getSize(header.column.columnDef.id)}
              >
                {header.isPlaceholder
                  ? null
                  : flexRender(
                      header.column.columnDef.header,
                      header.getContext()
                    )}
              </TableHead>
            );
          })}
        </TableRow>
      ))}
    </THeader>
  );
};

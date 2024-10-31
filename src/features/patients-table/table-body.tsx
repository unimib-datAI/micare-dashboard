import { flexRender, type Table } from '@tanstack/react-table';

import { TableBody as TBody, TableCell, TableRow } from '@/components/ui/table';

import { getSize } from './utils/get-column-size';

interface TableBodyProps<TData> {
  table: Table<TData>;
}

export const TableBody = <TData,>(props: TableBodyProps<TData>) => {
  const { table } = props;
  const numVisibleColumns = table.getVisibleFlatColumns().length;

  return (
    <TBody>
      {table.getRowModel().rows?.length ? (
        table.getRowModel().rows.map((row) => (
          <TableRow key={row.id} data-state={row.getIsSelected() && 'selected'}>
            {row.getVisibleCells().map((cell) => (
              <TableCell
                key={cell.id}
                className={getSize(cell.column.columnDef.id)}
              >
                {flexRender(cell.column.columnDef.cell, cell.getContext())}
              </TableCell>
            ))}
          </TableRow>
        ))
      ) : (
        <TableRow>
          <TableCell colSpan={numVisibleColumns} className={'h-24 text-center'}>
            Nessun paziente trovato.
          </TableCell>
        </TableRow>
      )}
    </TBody>
  );
};

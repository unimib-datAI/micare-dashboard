import { type Tag as Tag } from '@prisma/client';
import { type Table } from '@tanstack/react-table';

type Options = {
  value: string;
  label: string;
};

export function extractDiagnosisUniqueValue<T = { [key: string]: string }>({
  table,
  columnId,
}: {
  table: Table<T>;
  columnId: string;
  attribute?: string;
}): Options[] {
  const values = [
    ...new Set<string>(
      table.getCoreRowModel().flatRows.map((row) => row.getValue(columnId))
    ),
  ];

  const options: Options[] = values.map((value) => ({
    value: value?.toLowerCase(),
    label: value,
  }));

  return options;
}

export function extractTagsUniqueValue<T = { [key: string]: string }>({
  table,
  columnId,
}: {
  table: Table<T>;
  columnId: string;
}): Options[] {
  const tags: Tag[] = table
    .getCoreRowModel()
    .flatRows.map((row) => row.getValue(columnId));

  const values = [
    ...new Set<string>(
      tags
        .map((tag) => tag?.name)
        .filter((name) => name !== null && name !== undefined)
    ),
  ];

  const options: Options[] = values.map((value) => ({
    value: value?.toLowerCase(),
    label: value,
  }));

  return options;
}

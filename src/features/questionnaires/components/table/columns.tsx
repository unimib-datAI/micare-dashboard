import { type Administration } from '@prisma/client';
import { type ColumnDef } from '@tanstack/react-table';
import { format } from 'date-fns';
import { id, it } from 'date-fns/locale';
import { ArrowDownWideNarrow } from 'lucide-react';
import Link from 'next/link';
import Router from 'next/router';

import ExtendedLink from '@/components/extendend-link';
import { Button } from '@/components/ui/button';
import { Checkbox } from '@/components/ui/checkbox';

export const columns: ColumnDef<Administration>[] = [
  {
    id: 'checked',
    cell: (props) => {
      const { row } = props;
      return (
        <div className="flex items-center">
          <Checkbox
            checked={row.getIsSelected()}
            onCheckedChange={(value) => row.toggleSelected(!!value)}
          />
        </div>
      );
    },
  },
  {
    id: 'name',
    accessorKey: 'T',
    cell: (props) => {
      const { cell } = props;
      const T = cell.getValue() as number;
      return <p className="text-sm font-bold">{`T${T}`}</p>;
    },
    header: () => {
      return <p className="text-sm">#</p>;
    },
  },
  {
    id: 'date',
    accessorKey: 'date',
    sortingFn: 'datetime',
    cell: (props) => {
      const { getValue } = props;
      const dateString = format(getValue() as Date, 'dd/MM/yyyy', {
        locale: it,
      });
      return <p className="text-sm font-bold">{dateString}</p>;
    },
    header: (props) => {
      const { column } = props;
      const _isSorted = column.getIsSorted(); //TODO is the column sorted? false | 'asc' | 'desc'. Change the icon based on this.
      return (
        <Button
          onClick={column.getToggleSortingHandler()}
          className="flex flex-row gap-2 bg-transparent px-0 hover:bg-transparent"
        >
          <p className="text-sm uppercase">Data</p>
          <div className="flex flex-col justify-center">
            <ArrowDownWideNarrow size={16} />
          </div>
        </Button>
      );
    },
  },
  {
    id: 'open',
    accessorKey: 'id',
    header: () => <></>,
    cell: (props) => {
      const { getValue } = props;
      const administrationId = getValue() as string;

      return (
        <div className="flex w-full justify-end">
          <Button
            as={ExtendedLink}
            href={''}
            routeToAppend={`administration/${administrationId}`}
            variant="link"
            size="sm"
            className="ml-auto px-0 text-sm"
          >
            Vai ai risultati
          </Button>
        </div>
      );
    },
  },
];

export const columnsCompare: ColumnDef<Administration>[] = [
  {
    id: 'name',
    accessorKey: 'T',
    cell: (props) => {
      const { cell } = props;
      const T = cell.getValue() as number;
      return <p className="text-sm font-bold">{`T${T}`}</p>;
    },
    header: () => {
      return <p className="text-sm">#</p>;
    },
  },
  {
    id: 'date',
    accessorKey: 'date',
    sortingFn: 'datetime',
    cell: (props) => {
      const { getValue } = props;
      const dateString = format(getValue() as Date, 'dd/MM/yyyy', {
        locale: it,
      });
      return <p className="text-sm font-bold">{dateString}</p>;
    },
    header: (props) => {
      const { column } = props;
      return (
        <Button
          onClick={column.getToggleSortingHandler()}
          className="flex flex-row gap-2 bg-transparent px-0 hover:bg-transparent"
        >
          <p className="text-sm uppercase">Data</p>
          <div className="flex flex-col justify-center">
            <ArrowDownWideNarrow size={16} />
          </div>
        </Button>
      );
    },
  },
  {
    id: 'open',
    accessorFn: ({ id, type }) => ({ id, type }),
    header: () => <></>,
    cell: (props) => {
      const { cell } = props;
      const { username } = Router.query;
      const { id, type } = cell.getValue() as Administration;

      const goTo = `/patients/${
        username as string
      }/administrations/results/${type}/${id}`;

      return (
        <div className="flex w-full justify-end">
          <Button
            as={Link}
            variant="link"
            size="sm"
            className="ml-auto px-0 text-sm"
            href={goTo}
          >
            Vai ai risultati
          </Button>
        </div>
      );
    },
  },
];

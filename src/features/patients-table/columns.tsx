import { type Tag, type User } from '@prisma/client';
import { type ColumnDef } from '@tanstack/react-table';
import { ArrowUpDown } from 'lucide-react';
import Link from 'next/link';

import { Avatar, AvatarFallback, AvatarImage } from '@/components/ui/avatar';
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import { ComboboxPopover, type Options } from '@/components/ui/combobox';
import { type PatientWithRelations } from '@/types/patient-with-relations';
import { cn } from '@/utils/cn';
import { makeInitials } from '@/utils/make-initials';

import {
  extractDiagnosisUniqueValue,
  extractTagsUniqueValue,
} from './utils/column-value-extractor';

export const columns: ColumnDef<PatientWithRelations>[] = [
  {
    header: ({ column }) => {
      return (
        <Button
          variant="ghost"
          size="sm"
          className="pl-12 text-sm font-medium uppercase text-white [&:has([role=checkbox])]:pr-0"
          onClick={() => column.toggleSorting(column.getIsSorted() === 'asc')}
        >
          Paziente
          <ArrowUpDown className="ml-2 h-4 w-4 text-white" />
        </Button>
      );
    },
    id: 'name',
    accessorKey: 'user',
    accessorFn: (patient) => patient.user,
    filterFn: 'fuzzy',
    cell(props) {
      const { getValue } = props;
      const user = getValue() as User;
      if (!user) return null;
      return (
        <div className="grid grid-cols-[2.5rem_1fr] grid-rows-2 items-center gap-x-2 gap-y-1 whitespace-nowrap font-medium leading-none text-gray-900 dark:text-white">
          <Avatar className="row-span-2">
            <AvatarImage src={user.image ?? ''} placeholder="blur" />
            <AvatarFallback className="bg-forest-green-200 text-white">
              {makeInitials(user.name)}
            </AvatarFallback>
          </Avatar>
          <p className="self-end font-bold">{user.name}</p>
          <p className="self-start font-light">{user.email}</p>
        </div>
      );
    },
  },
  {
    id: 'diagnosi',
    header: (props) => {
      const { table } = props;
      const diagnosisOptions = extractDiagnosisUniqueValue({
        table,
        columnId: 'diagnosi',
      });

      if (diagnosisOptions.length === 1) return 'Diagnosi';

      return (
        <ComboboxPopover
          options={diagnosisOptions}
          emptyText="Nessun risultato"
          label="Diagnosi"
          placeholder="Cerca diagnosi..."
          value={
            (table.getColumn('diagnosi')?.getFilterValue() as string) ?? ''
          }
          setValue={(value) => {
            table.getColumn('diagnosi')?.setFilterValue(value);
          }}
          triggerClassName="text-sm -ml-2 bg-forest-green-700 uppercase text-white data-[state=open]:bg-forest-green-600"
          triggerText="Diagnosi"
        />
      );
    },
    accessorKey: 'medicalRecord.clinicalData.diagnosticHypothesis',
  },
  {
    id: 'terapia',
    header: 'Terapia',
    accessorKey: 'medicalRecord.intervention.therapeuticPlan',
    cell(props) {
      const { getValue } = props;
      const therapeuticPlan = getValue() as string;
      return (
        <p className="line-clamp-2 overflow-hidden text-ellipsis">
          {therapeuticPlan}
        </p>
      );
    },
  },
  {
    id: 'stato',
    header: (props) => {
      const { table } = props;

      const options: Options[] = [
        { label: 'In corso', value: 'in corso' },
        { label: 'Archiviato', value: 'archiviato' },
      ];

      const state = table.getColumn('stato')?.getFilterValue() as string;

      return (
        <ComboboxPopover
          options={options}
          emptyText="Nessun risultato"
          label="Stato"
          placeholder="Cerca diagnosi..."
          value={(table.getColumn('stato')?.getFilterValue() as string) ?? ''}
          setValue={(value) => {
            console.log({ state, value });
            table.getColumn('stato')?.setFilterValue(value);
          }}
          triggerClassName="text-sm -ml-2 bg-forest-green-700 uppercase text-white data-[state=open]:bg-forest-green-600"
          triggerText="Stato"
        />
      );
    },
    cell: (props) => {
      const { getValue } = props;
      const state = getValue() as string;
      return (
        <>
          <Badge
            className={cn(
              state === 'In corso' ? 'bg-emerald-400 ' : 'bg-red-400'
            )}
          >
            {state}
          </Badge>
        </>
      );
    },
    accessorKey: 'medicalRecord.ongoing',
    accessorFn: (patient) =>
      patient.medicalRecord?.ongoing ? 'In corso' : 'Archiviato',
  },
  {
    id: 'etichetta',
    enableHiding: true,
    header: (props) => {
      const { table } = props;
      const tagsOptions = extractTagsUniqueValue({
        table,
        columnId: 'etichetta',
      });

      if (tagsOptions.length > 0) {
        table.getColumn('etichetta')?.toggleVisibility(true);
      }

      if (tagsOptions.length === 1) return 'Etichetta';

      return (
        <ComboboxPopover
          options={tagsOptions}
          emptyText="Nessun risultato"
          label="Etichetta"
          placeholder="Cerca etichetta..."
          value={
            (table.getColumn('etichetta')?.getFilterValue() as string) ?? ''
          }
          setValue={(value) => {
            table.getColumn('etichetta')?.setFilterValue(value);
          }}
          triggerClassName={cn(
            'text-sm -ml-2 bg-forest-green-700 uppercase text-white data-[state=open]:bg-forest-green-600',
            tagsOptions.length === 0 && 'pointer-events-none'
          )}
          triggerText="Etichetta"
        />
      );
    },
    accessorKey: 'tags',
    cell(props) {
      const { getValue } = props;
      const tags = getValue() as Tag[];
      return tags.map((tag) => <Badge key={tag.id}>{tag.name}</Badge>);
    },
  },
  {
    id: 'actions',
    enableResizing: true,
    cell(props) {
      const { row } = props;
      const { user } = row.original;
      if (!user?.username) return null;

      return (
        <Button
          as={Link}
          href={`/patients/${user.username}/medical-records`}
          variant="link"
          size="sm"
          className="font-medium text-blue-600 hover:underline dark:text-blue-500"
        >
          <small>Apri</small>
        </Button>
      );
    },
  },
];

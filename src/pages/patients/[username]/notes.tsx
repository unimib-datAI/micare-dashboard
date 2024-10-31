import { ScrollArea } from '@radix-ui/react-scroll-area';
import { Plus, Search, Star } from 'lucide-react';
import { type NextPage } from 'next';
import { useContext, useState } from 'react';
import { type DateRange } from 'react-day-picker';

import { Button } from '@/components/ui/button';
import { DatePickerWithRange } from '@/components/ui/date-picker-range';
import { Input } from '@/components/ui/input';
import {
  Select,
  SelectContent,
  SelectGroup,
  SelectItem,
  SelectLabel,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';
import { Toggle } from '@/components/ui/toggle';
import { RootContainerRefContext } from '@/context';
import { Dialog } from '@/features/notes/components/add-note-dialog';
import { NoteCard } from '@/features/notes/components/note-card';
import {
  dateFilter,
  pinnedFilter,
  sortFn,
  titleFilter,
} from '@/features/notes/utils/filters';
import { usePatient } from '@/hooks/use-patient';
import { useUser } from '@/hooks/use-user';
import { _default as RootLayout, PatientLayout } from '@/layout';
import { api } from '@/utils/api';

const Notes: NextPage = () => {
  const [search, setSearch] = useState('');
  const [date, setDate] = useState<DateRange | undefined>();
  const [pinnedOnly, setPinnedOnly] = useState<boolean>(false);
  const [orderFilter, setOrderFilter] = useState('desc');
  const { patient } = usePatient();
  const { user } = useUser();
  const containerRef = useContext(RootContainerRefContext);

  const { data: notes, isLoading } = api.note.findMany.useQuery(
    {
      orderBy: {
        date: 'desc',
      },
      where: {
        patientId: patient?.id,
      },
    },
    {
      enabled: !!user && !!patient,
    }
  );

  if (isLoading || !notes) return null;

  return (
    <>
      <div className="sticky top-32 z-10 -mx-3 flex flex-row items-center justify-between bg-gray-10 p-3">
        <div className="flex flex-col gap-2">
          <div className="flex flex-row gap-4">
            <Input
              placeholder="Cerca nota"
              type="text"
              value={search}
              onChange={(e) => setSearch(e.target.value)}
              containerClassName="max-w-sm"
              IconRight={Search}
            />
            <DatePickerWithRange
              className="max-w-sm"
              date={date}
              setDate={setDate}
            />
            <Select onValueChange={setOrderFilter} value={orderFilter}>
              <SelectTrigger className="w-[180px]">
                <SelectValue placeholder="Ordina per" />
              </SelectTrigger>
              <SelectContent>
                <SelectGroup>
                  <SelectLabel>Ordina per</SelectLabel>
                  <SelectItem value="desc">Più recente</SelectItem>
                  <SelectItem value="asc">Meno recente</SelectItem>
                  <SelectItem value="pinned">In evidenza</SelectItem>
                </SelectGroup>
              </SelectContent>
            </Select>
            <Toggle
              aria-label="Mostra solo note in evidenza"
              size="lg"
              pressed={pinnedOnly}
              onPressedChange={setPinnedOnly}
              className="text-base text-slate-500 [&>svg]:data-[state=on]:fill-amber-300 [&>svg]:data-[state=on]:stroke-amber-300"
            >
              <span className="mr-2">In evidenza</span>
              <Star className="h-5 w-5" />
            </Toggle>
          </div>
        </div>
        <Dialog
          containerRef={containerRef}
          trigger={
            <Button>
              <span className="px-3">Crea nota</span>
              <Plus />
            </Button>
          }
        />
      </div>
      <ScrollArea className="flex-1">
        <div className="-mx-3 flex flex-wrap">
          {notes
            .filter((note) => titleFilter(note, search))
            .filter((note) => dateFilter(note, date))
            .filter((note) => pinnedFilter(note, pinnedOnly))
            .sort((a, b) =>
              sortFn(a, b, orderFilter as 'asc' | 'desc' | 'pinned')
            )
            .map((note) => (
              <NoteCard
                key={note.id}
                note={note}
                containerRef={containerRef}
                className="@xl:w-1/2 @4xl:w-1/3 @7xl:w-1/4"
              />
            ))}
        </div>
      </ScrollArea>
    </>
  );
};

export default Notes;

Notes.getLayout = (page) => {
  return (
    <RootLayout>
      <PatientLayout>{page}</PatientLayout>
    </RootLayout>
  );
};

import { type Note as TNote } from '@prisma/client';
import { Star } from 'lucide-react';

import { api } from '@/utils/api';
import { cn } from '@/utils/cn';

type Props = {
  note: TNote;
};

export const PinSelector = (props: Props) => {
  const { note } = props;

  const utils = api.useContext();
  const updateNote = api.note.update.useMutation({
    onSettled: () => {
      return utils.note.invalidate();
    },
  });

  const togglePinned = () => {
    return updateNote.mutate({
      where: {
        id: note.id,
      },
      data: {
        pinned: !note.pinned,
      },
    });
  };

  return (
    <Star
      onClick={togglePinned}
      className={cn(
        'h-5 w-5 cursor-pointer stroke-forest-green-600 transition-all duration-300',
        note.pinned && 'fill-amber-300 stroke-amber-300'
      )}
    />
  );
};

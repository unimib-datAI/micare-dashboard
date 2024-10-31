import { type NextPage } from 'next';
import { useSession } from 'next-auth/react';
import { type TagCreateInputSchema } from 'prisma/generated/zod';
import {
  Controller,
  type SubmitErrorHandler,
  type SubmitHandler,
  useForm,
} from 'react-hook-form';
import { type z } from 'zod';

import { api } from '@/utils/api';

// type TagCreateArgs = z.infer<typeof TagCreateArgsSchema>;

type TagCreateInput = z.infer<typeof TagCreateInputSchema>;

const Tags: NextPage = () => {
  const { data: session } = useSession();

  /**
   * fallisce perché ritorna array di tag e owner è dentro singolo tag
   */
  const { data: tags } = api.tag.findMany.useQuery(
    {
      where: {
        therapistId: session?.user?.id,
      },
    },
    {
      enabled: !!session,
    }
  );

  const utils = api.useContext();
  const createTag = api.tag.create.useMutation({
    onSuccess: async () => {
      await utils.tag.invalidate();
    },
  });

  const { handleSubmit, control } = useForm({
    defaultValues: {
      name: '',
      patientIds: [],
      therapistId: session?.user?.id,
    },
    // resolver: zodResolver(TagCreateArgsSchema),
  });

  const handleOnSubmit: SubmitHandler<TagCreateInput> = async (data) => {
    await createTag.mutateAsync({ data });
  };

  const handleOnError: SubmitErrorHandler<TagCreateInput> = (errors) => {
    console.log({ errors });
  };

  return (
    <>
      <main className="grid">
        <h1 className="font-h1">Tags page</h1>
        <form onSubmit={handleSubmit(handleOnSubmit, handleOnError)}>
          <Controller
            control={control}
            name="name"
            render={({ field }) => (
              <input
                className="mt-4 rounded-lg border-2 border-gray-300 px-4 py-2"
                type="text"
                placeholder="new..."
                {...field}
              />
            )}
          />

          <button
            className="mt-4 rounded-lg border-2 border-gray-300 px-4 py-2"
            type="submit"
          >
            Create
          </button>
        </form>
        {tags &&
          tags.map((tag) => (
            <div key={tag.id}>
              <p>{tag.name}</p>
            </div>
          ))}
      </main>
    </>
  );
};

export default Tags;

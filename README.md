# Create T3 App

This is a [T3 Stack](https://create.t3.gg/) project bootstrapped with `create-t3-app`.

## What's next? How do I make an app with this?

We try to keep this project as simple as possible, so you can start with just the scaffolding we set up for you, and add additional things later when they become necessary.

If you are not familiar with the different technologies used in this project, please refer to the respective docs. If you still are in the wind, please join our [Discord](https://t3.gg/discord) and ask for help.

- [Next.js](https://nextjs.org)
- [NextAuth.js](https://next-auth.js.org)
- [Prisma](https://prisma.io)
- [Tailwind CSS](https://tailwindcss.com)
- [tRPC](https://trpc.io)

## Learn More

To learn more about the [T3 Stack](https://create.t3.gg/), take a look at the following resources:

- [Documentation](https://create.t3.gg/)
- [Learn the T3 Stack](https://create.t3.gg/en/faq#what-learning-resources-are-currently-available) — Check out these awesome tutorials

You can check out the [create-t3-app GitHub repository](https://github.com/t3-oss/create-t3-app) — your feedback and contributions are welcome!

## How do I deploy this?

Follow our deployment guides for [Vercel](https://create.t3.gg/en/deployment/vercel), [Netlify](https://create.t3.gg/en/deployment/netlify) and [Docker](https://create.t3.gg/en/deployment/docker) for more information.

## Dump dp to update keycloak default settings

Access container with `postgres` user

```
docker exec -it -u postgres mapseh_postgres bash
```

Dump db into `tmp` folder

```
pg_dump keycloak > /tmp/dump.sql
```

Copy dump outside of container

```
docker cp /tmp/dump.sql <output path>
```

Copy content of dump in `multipledb`. Remember to preserve `\c keycloak` command during copy and to not format the file.

## Nginx config for production

In nginx.conf add the following

```
http {
    ...
    fastcgi_buffers 32 32k;
    fastcgi_buffer_size 64k;
    proxy_buffer_size   256k;
    proxy_buffers   4 512k;
    proxy_busy_buffers_size   512k;
}
```

## Keycloak

Remember to add to maps-eh client -> service account role -> assign role -> realm-management/realm-admin

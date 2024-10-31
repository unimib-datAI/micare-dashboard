#!/bin/bash

git pull;
pnpm install;
pnpm build;

docker restart mapseh_node;

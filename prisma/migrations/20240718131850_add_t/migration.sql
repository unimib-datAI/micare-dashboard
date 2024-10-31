/*
  Warnings:

  - Added the required column `T` to the `Administration` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Administration" ADD COLUMN     "T" INTEGER NOT NULL;

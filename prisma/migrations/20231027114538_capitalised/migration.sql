/*
  Warnings:

  - You are about to drop the `_patientTotag` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `account` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `administration` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `anamnesticData` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `clinicalData` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `intervention` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `medicalRecord` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `note` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `patient` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `tag` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `therapist` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `user` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "_patientTotag" DROP CONSTRAINT "_patientTotag_A_fkey";

-- DropForeignKey
ALTER TABLE "_patientTotag" DROP CONSTRAINT "_patientTotag_B_fkey";

-- DropForeignKey
ALTER TABLE "account" DROP CONSTRAINT "account_userId_fkey";

-- DropForeignKey
ALTER TABLE "administration" DROP CONSTRAINT "administration_medicalRecordId_fkey";

-- DropForeignKey
ALTER TABLE "anamnesticData" DROP CONSTRAINT "anamnesticData_medicalRecordId_fkey";

-- DropForeignKey
ALTER TABLE "clinicalData" DROP CONSTRAINT "clinicalData_medicalRecordId_fkey";

-- DropForeignKey
ALTER TABLE "intervention" DROP CONSTRAINT "intervention_medicalRecordId_fkey";

-- DropForeignKey
ALTER TABLE "medicalRecord" DROP CONSTRAINT "medicalRecord_patientId_fkey";

-- DropForeignKey
ALTER TABLE "note" DROP CONSTRAINT "note_patientId_fkey";

-- DropForeignKey
ALTER TABLE "note" DROP CONSTRAINT "note_therapistId_fkey";

-- DropForeignKey
ALTER TABLE "patient" DROP CONSTRAINT "patient_id_fkey";

-- DropForeignKey
ALTER TABLE "patient" DROP CONSTRAINT "patient_therapistId_fkey";

-- DropForeignKey
ALTER TABLE "sessions" DROP CONSTRAINT "sessions_userId_fkey";

-- DropForeignKey
ALTER TABLE "tag" DROP CONSTRAINT "tag_therapistId_fkey";

-- DropForeignKey
ALTER TABLE "therapist" DROP CONSTRAINT "therapist_id_fkey";

-- DropTable
DROP TABLE "_patientTotag";

-- DropTable
DROP TABLE "account";

-- DropTable
DROP TABLE "administration";

-- DropTable
DROP TABLE "anamnesticData";

-- DropTable
DROP TABLE "clinicalData";

-- DropTable
DROP TABLE "intervention";

-- DropTable
DROP TABLE "medicalRecord";

-- DropTable
DROP TABLE "note";

-- DropTable
DROP TABLE "patient";

-- DropTable
DROP TABLE "tag";

-- DropTable
DROP TABLE "therapist";

-- DropTable
DROP TABLE "user";

-- CreateTable
CREATE TABLE "Account" (
    "id" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "provider" TEXT NOT NULL,
    "providerAccountId" TEXT NOT NULL,
    "refresh_token" TEXT,
    "access_token" TEXT,
    "expires_at" INTEGER,
    "refresh_expires_in" INTEGER,
    "not_before_policy" INTEGER,
    "token_type" TEXT,
    "scope" TEXT,
    "id_token" TEXT,
    "session_state" TEXT,
    "userId" TEXT NOT NULL,

    CONSTRAINT "Account_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "username" TEXT,
    "name" TEXT,
    "email" TEXT NOT NULL,
    "emailVerified" TIMESTAMP(3),
    "image" TEXT,
    "roles" TEXT[] DEFAULT ARRAY[]::TEXT[],
    "phone" TEXT,
    "address" TEXT,
    "group" TEXT[],

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Therapist" (
    "id" TEXT NOT NULL,
    "tagsIds" INTEGER[],

    CONSTRAINT "Therapist_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Patient" (
    "id" TEXT NOT NULL,
    "tagsIds" INTEGER[],
    "therapistId" TEXT,

    CONSTRAINT "Patient_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AnamnesticData" (
    "id" TEXT NOT NULL,
    "age" INTEGER NOT NULL,
    "sex" "Sex" NOT NULL,
    "pronoun" TEXT NOT NULL,
    "schooling" TEXT NOT NULL,
    "birthPlace" TEXT NOT NULL,
    "previousInterventions" TEXT NOT NULL,
    "reason" TEXT NOT NULL,
    "medicalRecordId" TEXT NOT NULL,

    CONSTRAINT "AnamnesticData_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ClinicalData" (
    "id" TEXT NOT NULL,
    "diagnosticHypothesis" TEXT NOT NULL,
    "simptoms" TEXT NOT NULL,
    "medicalRecordId" TEXT NOT NULL,

    CONSTRAINT "ClinicalData_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Intervention" (
    "id" TEXT NOT NULL,
    "goals" TEXT NOT NULL,
    "therapeuticPlan" TEXT NOT NULL,
    "frequency" TEXT NOT NULL,
    "takingChargeDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "medicalRecordId" TEXT NOT NULL,

    CONSTRAINT "Intervention_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MedicalRecord" (
    "id" TEXT NOT NULL,
    "patientId" TEXT NOT NULL,
    "ongoing" BOOLEAN NOT NULL,

    CONSTRAINT "MedicalRecord_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Tag" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "patientIds" TEXT[],
    "therapistId" TEXT NOT NULL,

    CONSTRAINT "Tag_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Note" (
    "id" TEXT NOT NULL,
    "date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "pinned" BOOLEAN NOT NULL DEFAULT false,
    "title" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "therapistId" TEXT NOT NULL,
    "patientId" TEXT NOT NULL,

    CONSTRAINT "Note_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Administration" (
    "id" TEXT NOT NULL,
    "patientId" TEXT NOT NULL,
    "date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "type" TEXT NOT NULL,
    "records" JSONB NOT NULL,
    "medicalRecordId" TEXT NOT NULL,

    CONSTRAINT "Administration_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_PatientToTag" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "Account_providerAccountId_key" ON "Account"("providerAccountId");

-- CreateIndex
CREATE UNIQUE INDEX "Account_providerAccountId_userId_key" ON "Account"("providerAccountId", "userId");

-- CreateIndex
CREATE UNIQUE INDEX "User_username_key" ON "User"("username");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "AnamnesticData_medicalRecordId_key" ON "AnamnesticData"("medicalRecordId");

-- CreateIndex
CREATE UNIQUE INDEX "ClinicalData_medicalRecordId_key" ON "ClinicalData"("medicalRecordId");

-- CreateIndex
CREATE UNIQUE INDEX "Intervention_medicalRecordId_key" ON "Intervention"("medicalRecordId");

-- CreateIndex
CREATE UNIQUE INDEX "MedicalRecord_patientId_key" ON "MedicalRecord"("patientId");

-- CreateIndex
CREATE UNIQUE INDEX "_PatientToTag_AB_unique" ON "_PatientToTag"("A", "B");

-- CreateIndex
CREATE INDEX "_PatientToTag_B_index" ON "_PatientToTag"("B");

-- AddForeignKey
ALTER TABLE "Account" ADD CONSTRAINT "Account_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sessions" ADD CONSTRAINT "sessions_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Therapist" ADD CONSTRAINT "Therapist_id_fkey" FOREIGN KEY ("id") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Patient" ADD CONSTRAINT "Patient_therapistId_fkey" FOREIGN KEY ("therapistId") REFERENCES "Therapist"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Patient" ADD CONSTRAINT "Patient_id_fkey" FOREIGN KEY ("id") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AnamnesticData" ADD CONSTRAINT "AnamnesticData_medicalRecordId_fkey" FOREIGN KEY ("medicalRecordId") REFERENCES "MedicalRecord"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ClinicalData" ADD CONSTRAINT "ClinicalData_medicalRecordId_fkey" FOREIGN KEY ("medicalRecordId") REFERENCES "MedicalRecord"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Intervention" ADD CONSTRAINT "Intervention_medicalRecordId_fkey" FOREIGN KEY ("medicalRecordId") REFERENCES "MedicalRecord"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MedicalRecord" ADD CONSTRAINT "MedicalRecord_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES "Patient"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Tag" ADD CONSTRAINT "Tag_therapistId_fkey" FOREIGN KEY ("therapistId") REFERENCES "Therapist"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Note" ADD CONSTRAINT "Note_therapistId_fkey" FOREIGN KEY ("therapistId") REFERENCES "Therapist"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Note" ADD CONSTRAINT "Note_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES "Patient"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Administration" ADD CONSTRAINT "Administration_medicalRecordId_fkey" FOREIGN KEY ("medicalRecordId") REFERENCES "MedicalRecord"("id") ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE "_PatientToTag" ADD CONSTRAINT "_PatientToTag_A_fkey" FOREIGN KEY ("A") REFERENCES "Patient"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_PatientToTag" ADD CONSTRAINT "_PatientToTag_B_fkey" FOREIGN KEY ("B") REFERENCES "Tag"("id") ON DELETE CASCADE ON UPDATE CASCADE;

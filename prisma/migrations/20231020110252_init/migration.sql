-- CreateEnum
CREATE TYPE "Sex" AS ENUM ('M', 'F');

-- CreateEnum
CREATE TYPE "Role" AS ENUM ('therapist', 'patient');

-- CreateTable
CREATE TABLE "account" (
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

    CONSTRAINT "account_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sessions" (
    "id" TEXT NOT NULL,
    "session_token" TEXT NOT NULL,
    "expires" TIMESTAMP(3) NOT NULL,
    "userId" TEXT NOT NULL,

    CONSTRAINT "sessions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user" (
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

    CONSTRAINT "user_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "therapist" (
    "id" TEXT NOT NULL,
    "tagsIds" INTEGER[],

    CONSTRAINT "therapist_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "patient" (
    "id" TEXT NOT NULL,
    "tagsIds" INTEGER[],
    "therapistId" TEXT,

    CONSTRAINT "patient_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "anamnesticData" (
    "id" TEXT NOT NULL,
    "age" INTEGER NOT NULL,
    "sex" "Sex" NOT NULL,
    "pronoun" TEXT NOT NULL,
    "schooling" TEXT NOT NULL,
    "birthPlace" TEXT NOT NULL,
    "previousInterventions" TEXT NOT NULL,
    "reason" TEXT NOT NULL,
    "medicalRecordId" TEXT NOT NULL,

    CONSTRAINT "anamnesticData_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "clinicalData" (
    "id" TEXT NOT NULL,
    "diagnosticHypothesis" TEXT NOT NULL,
    "simptoms" TEXT NOT NULL,
    "medicalRecordId" TEXT NOT NULL,

    CONSTRAINT "clinicalData_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "intervention" (
    "id" TEXT NOT NULL,
    "goals" TEXT NOT NULL,
    "therapeuticPlan" TEXT NOT NULL,
    "frequency" TEXT NOT NULL,
    "takingChargeDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "medicalRecordId" TEXT NOT NULL,

    CONSTRAINT "intervention_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "medicalRecord" (
    "id" TEXT NOT NULL,
    "patientId" TEXT NOT NULL,
    "ongoing" BOOLEAN NOT NULL,

    CONSTRAINT "medicalRecord_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tag" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "patientIds" TEXT[],
    "therapistId" TEXT NOT NULL,

    CONSTRAINT "tag_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "note" (
    "id" TEXT NOT NULL,
    "date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "pinned" BOOLEAN NOT NULL DEFAULT false,
    "title" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "therapistId" TEXT NOT NULL,
    "patientId" TEXT NOT NULL,

    CONSTRAINT "note_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "administration" (
    "id" TEXT NOT NULL,
    "patientId" TEXT NOT NULL,
    "date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "type" TEXT NOT NULL,
    "records" JSONB NOT NULL,
    "medicalRecordId" TEXT NOT NULL,

    CONSTRAINT "administration_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_patientTotag" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "account_providerAccountId_key" ON "account"("providerAccountId");

-- CreateIndex
CREATE UNIQUE INDEX "account_providerAccountId_userId_key" ON "account"("providerAccountId", "userId");

-- CreateIndex
CREATE UNIQUE INDEX "sessions_session_token_key" ON "sessions"("session_token");

-- CreateIndex
CREATE UNIQUE INDEX "user_username_key" ON "user"("username");

-- CreateIndex
CREATE UNIQUE INDEX "user_email_key" ON "user"("email");

-- CreateIndex
CREATE UNIQUE INDEX "anamnesticData_medicalRecordId_key" ON "anamnesticData"("medicalRecordId");

-- CreateIndex
CREATE UNIQUE INDEX "clinicalData_medicalRecordId_key" ON "clinicalData"("medicalRecordId");

-- CreateIndex
CREATE UNIQUE INDEX "intervention_medicalRecordId_key" ON "intervention"("medicalRecordId");

-- CreateIndex
CREATE UNIQUE INDEX "medicalRecord_patientId_key" ON "medicalRecord"("patientId");

-- CreateIndex
CREATE UNIQUE INDEX "_patientTotag_AB_unique" ON "_patientTotag"("A", "B");

-- CreateIndex
CREATE INDEX "_patientTotag_B_index" ON "_patientTotag"("B");

-- AddForeignKey
ALTER TABLE "account" ADD CONSTRAINT "account_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sessions" ADD CONSTRAINT "sessions_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "therapist" ADD CONSTRAINT "therapist_id_fkey" FOREIGN KEY ("id") REFERENCES "user"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "patient" ADD CONSTRAINT "patient_therapistId_fkey" FOREIGN KEY ("therapistId") REFERENCES "therapist"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "patient" ADD CONSTRAINT "patient_id_fkey" FOREIGN KEY ("id") REFERENCES "user"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "anamnesticData" ADD CONSTRAINT "anamnesticData_medicalRecordId_fkey" FOREIGN KEY ("medicalRecordId") REFERENCES "medicalRecord"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "clinicalData" ADD CONSTRAINT "clinicalData_medicalRecordId_fkey" FOREIGN KEY ("medicalRecordId") REFERENCES "medicalRecord"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "intervention" ADD CONSTRAINT "intervention_medicalRecordId_fkey" FOREIGN KEY ("medicalRecordId") REFERENCES "medicalRecord"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "medicalRecord" ADD CONSTRAINT "medicalRecord_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES "patient"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tag" ADD CONSTRAINT "tag_therapistId_fkey" FOREIGN KEY ("therapistId") REFERENCES "therapist"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "note" ADD CONSTRAINT "note_therapistId_fkey" FOREIGN KEY ("therapistId") REFERENCES "therapist"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "note" ADD CONSTRAINT "note_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES "patient"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "administration" ADD CONSTRAINT "administration_medicalRecordId_fkey" FOREIGN KEY ("medicalRecordId") REFERENCES "medicalRecord"("id") ON DELETE CASCADE ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE "_patientTotag" ADD CONSTRAINT "_patientTotag_A_fkey" FOREIGN KEY ("A") REFERENCES "patient"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_patientTotag" ADD CONSTRAINT "_patientTotag_B_fkey" FOREIGN KEY ("B") REFERENCES "tag"("id") ON DELETE CASCADE ON UPDATE CASCADE;

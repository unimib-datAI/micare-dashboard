import {
  type MedicalRecord,
  type Patient,
  type Tag,
  type User,
} from '@prisma/client';

export type PatientWithRelations = Patient & {
  user: User | null;
  tags: Tag[] | null;
  medicalRecord: MedicalRecord | null;
};

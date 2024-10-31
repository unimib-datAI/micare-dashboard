import { motion } from 'framer-motion';
import { type SVGProps } from 'react';
import { useContext } from 'react';

import { useValidateStep } from '@/features/add-patient/hooks';
import {
  type accountSchema,
  type anamnesisSchema,
  type clinicalDataSchema,
  type interventionSchema,
} from '@/types/zod/schema';
import { cn } from '@/utils/cn';

import { WizardContext } from './wizard';

type Props = {
  step: number;
  className?: string;
  schema:
    | typeof accountSchema
    | typeof anamnesisSchema
    | typeof clinicalDataSchema
    | typeof interventionSchema;
  children: React.ReactNode;
};

export const WizardStep = (props: Props) => {
  const { step, className, children, schema } = props;

  const { currentStep, totalStep } = useContext(WizardContext);
  const { status } = useValidateStep(step, currentStep, schema, totalStep);

  return (
    <div className="flex flex-col items-center justify-start">
      {status && (
        <motion.div animate={status} className="relative">
          <motion.div
            variants={{
              active: {
                scale: 1,
                transition: {
                  delay: 0,
                  duration: 0.2,
                },
              },
              complete: {
                backgroundColor: 'var(--forest-green-200)',
                scale: 1.25,
              },
              error: {
                backgroundColor: 'var(--red-200)',
                scale: 1.25,
              },
            }}
            transition={{
              duration: 0.6,
              delay: 0.2,
              type: 'tween',
              ease: 'circOut',
            }}
            className="absolute inset-0 rounded-full"
          ></motion.div>

          <motion.div
            initial={false}
            variants={{
              inactive: {
                backgroundColor: 'var(--white)',
                borderColor: 'var(--slate-200)',
                color: 'var(--slate-400)',
              },
              active: {
                backgroundColor: 'var(--white)',
                borderColor: 'var(--forest-green-400)',
                color: 'var(--forest-green-400)',
              },
              error: {
                backgroundColor: 'var(--red-400)',
                borderColor: 'var(--red-400)',
                color: 'var(--red-400)',
              },
              complete: {
                backgroundColor: 'var(--forest-green-400)',
                borderColor: 'var(--forest-green-400)',
                color: 'var(--forest-green-400)',
              },
            }}
            transition={{ duration: 0.2 }}
            className={cn(
              `relative flex h-10 w-10 items-center justify-center rounded-full border-2 font-semibold`,
              className
            )}
          >
            <div className="flex items-center justify-start">
              {status === 'complete' ? (
                <CheckIcon className="h-6 w-6 text-white" />
              ) : status === 'error' ? (
                <CrossIcon className="h-6 w-6 text-white" />
              ) : (
                <span>{step + 1}</span>
              )}
            </div>
          </motion.div>
        </motion.div>
      )}
      <span
        className={cn(
          status === 'active' && 'text-forest-green-400',
          status === 'inactive' && 'text-slate-400',
          status === 'error' && 'text-red-200',
          status === 'complete' && 'text-forest-green-200',
          'mt-2 max-w-[11ch] text-center leading-[1rem]'
        )}
      >
        {children}
      </span>
    </div>
  );
};

function CheckIcon(props: SVGProps<SVGSVGElement>) {
  return (
    <svg
      {...props}
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor"
      strokeWidth={3}
    >
      <motion.path
        initial={{ pathLength: 0 }}
        animate={{ pathLength: 1 }}
        transition={{
          delay: 0.2,
          type: 'tween',
          ease: 'easeOut',
          duration: 0.3,
        }}
        strokeLinecap="round"
        strokeLinejoin="round"
        d="M5 13l4 4L19 7"
      />
    </svg>
  );
}

function CrossIcon(props: SVGProps<SVGSVGElement>) {
  return (
    <svg
      {...props}
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor"
      strokeWidth={3}
    >
      <motion.line
        x1="5"
        y1="5"
        x2="19"
        y2="19"
        initial={{ pathLength: 0 }}
        animate={{ pathLength: 1 }}
        transition={{
          delay: 0.2,
          type: 'tween',
          ease: 'easeOut',
          duration: 0.3,
        }}
        strokeLinecap="round"
        strokeLinejoin="round"
      />
      <motion.line
        x1="5"
        y1="19"
        x2="19"
        y2="5"
        initial={{ pathLength: 0 }}
        animate={{ pathLength: 1 }}
        transition={{
          delay: 0.2,
          type: 'tween',
          ease: 'easeOut',
          duration: 0.3,
        }}
        strokeLinecap="round"
        strokeLinejoin="round"
      />
    </svg>
  );
}

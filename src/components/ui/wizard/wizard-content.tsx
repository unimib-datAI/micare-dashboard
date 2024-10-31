import { motion, MotionConfig } from 'framer-motion';
import { useContext } from 'react';

import { cn } from '@/utils/cn';

import { WizardContext } from './wizard';

type Props = {
  children: React.ReactNode;
  className?: string;
};

export const WizardContent = (props: Props) => {
  const { children, className } = props;

  const { currentStep } = useContext(WizardContext);
  return (
    <MotionConfig transition={{ duration: 0.7, ease: [0.32, 0.72, 0, 1] }}>
      <div className={cn('bg-white', className)}>
        <div className="flex h-full flex-col items-center justify-start">
          <div className="relative overflow-hidden">
            <motion.div
              animate={{ x: `-${currentStep * 100}%` }}
              className="flex h-full flex-nowrap"
            >
              {children}
            </motion.div>
          </div>
        </div>
      </div>
    </MotionConfig>
  );
};

import { useRef, useState } from 'react';

import Header from '@/components/ui/header';
import Sidebar from '@/components/ui/sidebar';
import { RootContainerRefContext } from '@/context';
import { useAuth } from '@/hooks/use-auth';
// import { Page } from '@/layout'; layout for animation between pages
import { cn } from '@/utils/cn';

type Props = {
  children: React.ReactNode;
};

const Layout = ({ children }: Props) => {
  const [collapsed, setCollapsed] = useState(false);
  const rootContainerRef = useRef<HTMLDivElement>(null);

  useAuth(true);

  return (
    <>
      <Header />
      <div
        className={cn(
          'relative grid',
          collapsed ? 'grid-cols-sidebar-collapse' : 'grid-cols-sidebar',
          'transition-[grid-template-columns] duration-300 ease-in-out'
        )}
      >
        <Sidebar collapsed={collapsed} setCollapsed={setCollapsed} />
        <div
          ref={rootContainerRef}
          className="relative mt-[calc(theme(spacing.16))] bg-gray-10 @container"
        >
          <RootContainerRefContext.Provider value={rootContainerRef}>
            {children}
          </RootContainerRefContext.Provider>
        </div>
      </div>
    </>
  );
};

export default Layout;

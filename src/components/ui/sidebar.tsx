import { AnimatePresence, motion } from 'framer-motion';
import {
  BarChart3,
  CalendarDays,
  Flag,
  History,
  PanelLeftClose,
  PanelLeftOpen,
  Tag,
  Users,
} from 'lucide-react';
import { type Dispatch, type SetStateAction } from 'react';

import ActiveLink from '@/components/active-link';
import { Separator } from '@/components/ui/separator';
import { cn } from '@/utils/cn';

const ITEMS = [
  { href: '/', icon: Users, label: 'Pazienti' },
  { href: '/recents', icon: History, label: 'Aperti di recente' },
  { href: '/tags', icon: Tag, label: 'Etichette' },
  { href: '/effectiveness', icon: Flag, label: 'Efficacia' },
  { href: '/research', icon: BarChart3, label: 'Ricerca' },
  { href: '/agenda', icon: CalendarDays, label: 'Agenda' },
];

const MotionPanelLeftOpen = motion(PanelLeftOpen);
const MotionPanelLeftClose = motion(PanelLeftClose);

type Props = {
  collapsed: boolean;
  setCollapsed: Dispatch<SetStateAction<boolean>>;
};

const Sidebar = (props: Props) => {
  const { collapsed, setCollapsed } = props;

  return (
    <aside
      className="sticky top-0 h-screen self-start bg-white pt-20"
      aria-label="Sidebar"
    >
      <nav className="h-full flex-grow overflow-y-auto px-3 pb-4">
        <ul className="flex h-full flex-col items-stretch justify-start gap-2">
          {ITEMS.map((item, index) => (
            <li key={item.href}>
              <ActiveLink
                href={item.href}
                className={cn(
                  'sidebar-link',
                  index !== 0 &&
                    'pointer-events-none cursor-not-allowed opacity-50' // TODO: Disable pointer events and change cursor to not-allowed for all links except the first one during tests
                )}
                activeClassName="sidebar-link-active"
              >
                <item.icon className="sidebar-icon opacity-60" />
                <span className="ml-3 flex-1 whitespace-nowrap">
                  {item.label}
                </span>
              </ActiveLink>
            </li>
          ))}
          <li className="mt-auto">
            <Separator className="my-2 bg-forest-green-700/20" aria-hidden />
            <button
              className="sidebar-link mt-2 w-full text-left"
              type="button"
              onClick={() => setCollapsed((prev) => !prev)}
            >
              <AnimatePresence initial={false}>
                <MotionPanelLeftClose
                  className="sidebar-icon"
                  key="chevrons-right-left"
                  initial={{ opacity: 0 }}
                  animate={{
                    opacity: collapsed ? 0 : 1,
                    transitionEnd: {
                      display: collapsed ? 'none' : 'flex',
                    },
                  }}
                  exit={{ opacity: 0 }}
                />
                <MotionPanelLeftOpen
                  className="sidebar-icon"
                  key="chevrons-left-right"
                  initial={{ opacity: 0 }}
                  animate={{
                    opacity: collapsed ? 1 : 0,
                    transitionEnd: {
                      display: collapsed ? 'flex' : 'none',
                    },
                  }}
                  exit={{ opacity: 0 }}
                />
              </AnimatePresence>
              <span className="ml-3 whitespace-nowrap">Collapse Sidebar</span>
            </button>
          </li>
        </ul>
      </nav>
    </aside>
  );
};

export default Sidebar;

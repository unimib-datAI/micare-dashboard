// eslint-disable-next-line @typescript-eslint/no-var-requires
const { fontFamily } = require('tailwindcss/defaultTheme');
// eslint-disable-next-line @typescript-eslint/no-var-requires
const colors = require('tailwindcss/colors');

/** @type {import('tailwindcss').Config} */
const config = {
  darkMode: ['class', '[data-theme="dark"]'],
  content: ['./src/**/*.{js,ts,jsx,tsx}'],
  theme: {
    fontSize: {
      sm: ['var(--fs-sm)', '1.25rem'],
      base: ['var(--fs-base)', '1.5rem'],
      lg: ['var(--fs-lg)', '1.75rem'],
      xl: ['var(--fs-xl)', '1.75em'],
    },
    extend: {
      colors: {
        background: 'hsl(var(--background))',
        foreground: 'hsl(var(--foreground))',
        muted: 'hsl(var(--muted))',
        'muted-foreground': 'hsl(var(--muted-foreground))',
        popover: 'hsl(var(--popover))',
        'popover-foreground': 'hsl(var(--popover-foreground))',
        card: 'hsl(var(--card))',
        'card-foreground': 'hsl(var(--card-foreground))',
        border: 'hsl(var(--border))',
        input: 'hsl(var(--input))',
        destructive: 'hsl(var(--destructive))',
        'destructive-foreground': 'hsl(var(--destructive-foreground))',
        ring: 'hsl(var(--ring))',
        radius: 'var(--radius)',
        transparent: 'transparent',
        current: 'currentColor',
        gray: {
          10: '#FAFAFA',
          20: '#DCE4E6',
          30: '#C4CaCC',
          ...colors.gray,
        },
        'forest-green': {
          700: '#2D7C35',
          600: '#57965D',
          500: '#76AA7C',
          400: '#96BD9A',
          300: '#B5D1B8',
          200: '#CADECC',
        },
        'darkest-blue': '#0E2210',
        'space-gray': '#1C1E33',
      },
      height: ({ theme }) => ({
        'screen-safe': `calc(100dvh - ${theme('spacing.6')} - ${theme(
          'spacing.16'
        )})`,
      }),
      minHeight: ({ theme }) => ({
        'screen-safe': `calc(100dvh - ${theme('spacing.6')} - ${theme(
          'spacing.16'
        )})`,
      }),
      fontFamily: {
        rubik: ['var(--ff-rubik)', ...fontFamily.sans],
        poppins: ['var(--ff-poppins)', ...fontFamily.sans],
      },
      maxWidth: ({ theme }) => ({
        6: theme('spacing.6'),
      }),
      keyframes: {
        'slide-down': {
          from: { height: '0' },
          to: { height: 'var(--radix-collapsible-content-height)' },
        },
        'slide-up': {
          from: { height: 'var(--radix-collapsible-content-height)' },
          to: { height: '0' },
        },
        'accordion-down': {
          from: { height: '0' },
          to: { height: 'var(--radix-accordion-content-height)' },
        },
        'accordion-up': {
          from: { height: 'var(--radix-accordion-content-height)' },
          to: { height: '0' },
        },
        fadein: {
          from: { opacity: '0' },
          to: { opacity: '1' },
        },
        shimmering: {
          from: { backgroundPosition: 'top right' },
          to: { backgroundPosition: 'top left' },
        },
        shake: {
          '10%, 90%': { transform: 'translate3d(-1px, 0, 0)' },
          '20%, 80%': { transform: 'translate3d(2px, 0, 0)' },
          '30%, 50%, 70%': { transform: 'translate3d(-4px, 0, 0)' },
          '40%, 60%': { transform: 'translate3d(4px, 0, 0)' },
        },
      },
      gridTemplateColumns: ({ theme }) => ({
        sidebar: `${theme('spacing.64')} 1fr`,
        'sidebar-collapse': `${theme('spacing.16')} 1fr`,
      }),
      animation: {
        'slide-down': 'slide-down 0.25s ease-out',
        'slide-up': 'slide-up 0.25s ease-out',
        'accordion-down': 'accordion-down 0.2s ease-out',
        'accordion-up': 'accordion-up 0.2s ease-out',
        shimmering:
          'shimmering forwards infinite ease-in-out, fadein 0.02s forwards',
        shake: 'shake 0.82s cubic-bezier(.36,.07,.19,.97) both',
        'fade-in': 'fadein 0.5s ease-in-out',
        'fade-out': 'fadein 0.5s ease-in-out reverse',
      },
    },
  },
  plugins: [
    require('@tailwindcss/container-queries'),
    require('tailwindcss-animate'),
    require('./tailwindcss-color-extractor.cjs'),
  ],
};

module.exports = config;

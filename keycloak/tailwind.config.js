const colors = require('tailwindcss/colors');

/**
 * @type { import('tailwindcss').Config }
 */
module.exports = {
  content: ['./themes/**/*.ftl'],
  experimental: {
    optimizeUniversalDefaults: true,
  },
  plugins: [require('@tailwindcss/forms')],
  theme: {
    extend: {
      colors: {
        primary: colors.blue,
        secondary: colors.gray,

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
        provider: {
          bitbucket: '#0052CC',
          discord: '#5865F2',
          facebook: '#1877F2',
          github: '#181717',
          gitlab: '#FC6D26',
          google: '#4285F4',
          instagram: '#E4405F',
          linkedin: '#0A66C2',
          microsoft: '#5E5E5E',
          oidc: '#F78C40',
          openshift: '#EE0000',
          paypal: '#00457C',
          slack: '#4A154B',
          stackoverflow: '#F58025',
          twitter: '#1DA1F2',
        },
      },
      spacing: {
        16: '4rem',
        32: '8rem',
      }
    },
  },
};

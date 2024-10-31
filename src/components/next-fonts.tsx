import { Poppins, Rubik } from 'next/font/google';

const rubik = Rubik({
  weight: ['500'],
  subsets: ['latin-ext'],
});

const poppins = Poppins({
  weight: ['300', '400', '600'],
  subsets: ['latin-ext'],
});

export const NextFonts = () => (
  <style jsx global>{`
    :root {
      --ff-rubik: ${rubik.style.fontFamily};
      --ff-poppins: ${poppins.style.fontFamily};
    }
  `}</style>
);

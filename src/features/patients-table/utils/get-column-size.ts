export const getSize = (id: string | undefined) => {
  switch (id) {
    case 'name':
      return 'w-72';
      break;
    case 'diagnosi':
      return 'w-72';
      break;
    case 'terapia':
      return 'grow-1';
      break;
    case 'stato':
      return 'w-32';
      break;
    case 'etichetta':
      return 'w-32';
      break;
    case 'actions':
      return 'w-20';
      break;
    default:
      return 'grow-0';
  }
};

export function toBase64(file: File) {
  return new Promise<string | null>((resolve, reject) => {
    const reader = new FileReader();
    reader.readAsDataURL(file);
    reader.onloadend = () => {
      if (typeof reader.result !== 'string') {
        return resolve(null);
      }
      resolve(reader.result);
    };
    reader.onerror = (error) => reject(error);
  });
}

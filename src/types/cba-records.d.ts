export interface CbaRecord {
  response: {
    [key: string]: string;
  };
  scores: {
    ansia: number;
    depressione: number;
    cambiamento: number;
    disagio: number;
    benessere: number;
  };
}

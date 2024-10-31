async function http<T>(path: string, config: RequestInit): Promise<T> {
  const request = new Request(path, config);
  const response = await fetch(request);

  return response.json() as Promise<T>;
}

export async function get<T>(path: string, config?: RequestInit): Promise<T> {
  const init = { method: 'get', ...config };
  return await http<T>(path, init);
}

export async function post<T, U>(
  path: string,
  data: T,
  config?: RequestInit
): Promise<U> {
  const body = typeof data === 'string' ? data : JSON.stringify(data);
  const init = { method: 'post', body, ...config };
  return await http<U>(path, init);
}

export async function put<T, U>(
  path: string,
  body: T,
  config?: RequestInit
): Promise<U> {
  const init = { method: 'put', body: JSON.stringify(body), ...config };
  return await http<U>(path, init);
}

export async function del<T>(path: string, config?: RequestInit): Promise<T> {
  const init = { method: 'delete', ...config };
  return await http<T>(path, init);
}

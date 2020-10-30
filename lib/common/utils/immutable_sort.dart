List<T> sort<T>(List<T> list, bool Function(T, T) compare) {
  final listCopy = List<T>.of(list);
  listCopy.sort((a, b) => compare(a, b) ? 1 : -1);

  return listCopy;
}

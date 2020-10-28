T Function(String) createEnumFromString<T>(Iterable<T> values) {
  return (String value) => values.firstWhere(
      (type) => type.toString().split('.').last == value,
      orElse: () => null);
}

String Function(T) createEnumToString<T>(Iterable<T> values) {
  return (T value) => value.toString().split('.').last;
}

extension SortExtension<T> on Iterable<T> {
  List<T> sorted([int Function(T a, T b)? compare]) => [...this]..sort(compare);
}

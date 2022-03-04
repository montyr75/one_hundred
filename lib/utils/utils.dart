extension IterableIntX on Iterable<int> {
  int sum() => fold(0, (int total, int current) => total + current);
}

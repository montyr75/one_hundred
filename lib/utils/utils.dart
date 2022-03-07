extension IterableIntX on Iterable<int> {
  int sum() => fold(0, (int total, int current) => total + current);
}

extension ListX on List {
  void replaceAt(int index, replacement) {
    this[index] = replacement;
  }

  void replaceWith(original, replacement) {
    replaceAt(indexOf(original), replacement);
  }
}

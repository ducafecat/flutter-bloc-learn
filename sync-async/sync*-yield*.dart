main() {
  getList(10).forEach(print);
}

Iterable<int> getList(int count) sync* {
  yield* generate(count);
}

Iterable<int> generate(int count) sync* {
  for (int i = 0; i < count; i++) {
    yield i;
  }
}

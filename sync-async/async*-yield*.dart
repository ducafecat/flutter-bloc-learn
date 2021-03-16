main() {
  getList(10).listen(print);
}

Stream<int> getList(int count) async* {
  yield* generate(count);
}

Stream<int> generate(int count) async* {
  for (int i = 0; i < count; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield i;
  }
}

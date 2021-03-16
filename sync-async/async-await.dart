main() {
  print("start..........");
  getList(10).then(print);
}

Future<int> getList(int count) async {
  await sleep();
  for (int i = 0; i < count; i++) {
    return i;
  }
  return 99;
}

Future sleep() async {
  return Future.delayed(Duration(seconds: 3));
}

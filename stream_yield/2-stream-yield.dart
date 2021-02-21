/*
 * 说明: 异步生成器 yield
 *
 */

// 生成多个异步函数
Stream<int> createStream(int max) async* {
  for (var i = 0; i < max; i++) {
    yield* fun(i);
  }
}

// 异步函数
Stream<int> fun(int val) async* {
  yield val;
}

// 异步函数执行并求和
Future<int> sumStream(Stream<int> items) async {
  int sumNum = 0;
  await for (var val in items) {
    print(val);
    sumNum += val;
  }
  return sumNum;
}

main(List<String> args) async {
  print('--- start ---');

  Stream<int> streamItems = createStream(10);
  int sumNum = await sumStream(streamItems);

  print('sumNum -> $sumNum');

  print('--- end ---');
}

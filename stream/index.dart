/*
 *
 * 说明: Stream 常见操作
 *
 */

import 'dart:async';

/////////////////////////////////////////

printStream(Stream<Object> stream) async {
  await for (var val in stream) {
    print(val);
  }
}

Future<int> funi = Future(() {
  return 100;
});

Future<int> funii = Future(() {
  return 200;
});

///////////////////////////////////////////////
/// 初始

// 延迟间隔
periodic() async {
  Stream<int> stream = Stream<int>.periodic(Duration(seconds: 1), (val) => val);
  await printStream(stream);
}

// futrue 数据源
fromFuture() async {
  Stream<int> stream = Stream<int>.fromFuture(funi);
  await printStream(stream);
}

// futrues 多数据源
fromFutures() async {
  Stream<int> stream = Stream<int>.fromFutures([
    funi,
    funii,
  ]);
  await printStream(stream);
}

///////////////////////////////////////////////
/// 监听

// 单对单
listen() async {
  Stream<int> stream = Stream<int>.periodic(Duration(seconds: 1), (val) => val);

  stream.listen(
    (event) {
      print(event);
    },
    onError: (err) {
      print(err);
    },
    onDone: () {},
    cancelOnError: true,
  );
}

// 广播
boardcast() async {
  Stream<int> stream = Stream<int>.periodic(Duration(seconds: 1), (val) => val)
      .asBroadcastStream();
  stream.listen((event) {
    print(event);
  });
  stream.listen((event) {
    print(event);
  });
}

// 操作
// task skip
task() async {
  Stream<int> stream = Stream<int>.fromIterable([1, 2, 3, 4, 5]);
  stream = stream.take(3);
  // stream = stream.skip(2);

  stream.listen((event) {
    print(event);
  });
}

///////////////////////////////////////////////
/// 流控制类

// StreamController listen
scListen() async {
  StreamController sc = StreamController(
      onListen: () => print("onListen"),
      onPause: () => print("onPause"),
      onResume: () => print("onResume"),
      onCancel: () => print("onCancel"),
      sync: false);

  // 订阅对象
  StreamSubscription ss = sc.stream.listen(((event) {
    print(event);
  }));

  sc.add(100);

  // 暂停
  ss.pause();
  // 恢复
  ss.resume();
  // 取消
  ss.cancel();

  // 关闭流
  sc.close();
}

// StreamController Broadcast
scBroadcast() async {
  StreamController sc = StreamController.broadcast();

  StreamSubscription ss1 = sc.stream.listen(print);
  StreamSubscription ss2 = sc.stream.listen(print);

  sc.addStream(Stream.fromIterable([1, 2, 3, 4, 5]));

  await Future.delayed(Duration(seconds: 2));
  sc.close();
}

// StreamTransformer
scTransformer() async {
  StreamController sc = StreamController<int>.broadcast();

  StreamTransformer stf = StreamTransformer<int, double>.fromHandlers(
    handleData: (int data, EventSink sink) {
      sink.add((data * 2).toDouble());
    },
    handleError: (Object error, StackTrace stacktrace, EventSink sink) {
      sink.addError('wrong: $error');
    },
    handleDone: (EventSink sink) {
      sink.close();
    },
  );

  Stream stream = sc.stream.transform(stf);
  stream.listen(print);
  stream.listen(print);

  sc.addStream(Stream<int>.fromIterable([1, 2, 3, 4, 5]));

  await Future.delayed(Duration(seconds: 2));
  sc.close();
}

main(List<String> args) async {
  print('--- start ---');

  // await periodic();
  // await fromFuture();
  // await fromFutures();

  // await listen();
  // await boardcast();
  // await task();

  // await scListen();
  // await scBroadcast();
  // await scTransformer();

  print('--- end ---');
}

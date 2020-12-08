part of 'counter_bloc.dart';

@immutable
abstract class CounterState extends Equatable {
  final int value;

  const CounterState(this.value);

  @override
  List<Object> get props => [value];
}

class CounterInitial extends CounterState {
  CounterInitial(int value) : super(value);
}

class CounterChange extends CounterState {
  CounterChange(int value) : super(value);
}

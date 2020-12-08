part of 'counter_bloc.dart';

@immutable
abstract class CounterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CounterIncrement extends CounterEvent {}

class CounterSubduction extends CounterEvent {}

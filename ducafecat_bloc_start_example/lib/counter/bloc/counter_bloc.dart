import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterInitial(0));

  int counterNum = 0;

  @override
  Stream<CounterState> mapEventToState(
    CounterEvent event,
  ) async* {
    if (event is CounterIncrement) {
      yield* _mapIncrementEventToState(event);
    } else if (event is CounterSubduction) {
      yield* _mapSubductionEventToState(event);
    }
  }

  Stream<CounterState> _mapIncrementEventToState(
      CounterIncrement event) async* {
    this.counterNum += 1;
    yield CounterChange(this.counterNum);
  }

  Stream<CounterState> _mapSubductionEventToState(
      CounterSubduction event) async* {
    this.counterNum -= 1;
    yield CounterChange(this.counterNum);
  }
}

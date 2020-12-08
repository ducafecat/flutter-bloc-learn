import 'package:ducafecat_bloc_start_example/counter/bloc/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterView extends StatelessWidget {
  const CounterView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Counter')),
      body: Center(
        child: Column(
          children: [
            BlocBuilder<CounterBloc, CounterState>(
              builder: (context, state) {
                return Text('${state.value}');
              },
            ),
            RaisedButton(
              child: Text('加法'),
              onPressed: () {
                BlocProvider.of<CounterBloc>(context).add(CounterIncrement());
              },
            ),
            RaisedButton(
              child: Text('加法'),
              onPressed: () {
                BlocProvider.of<CounterBloc>(context).add(CounterSubduction());
              },
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_timer/timer/cubit/timer_cubit.dart';
import 'package:workout_timer/timer/timer_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (BuildContext context) => TimerRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<TimerCubit>(
            create: (BuildContext context) =>
                TimerCubit(timerRepository: (context.read())),
          )
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const MyHomePage(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final dataBloc = BlocProvider.of<TimerCubit>(context);
    final repository = RepositoryProvider.of<TimerRepository>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('timer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<TimerCubit, TimerState>(builder: (context, state) {
              return Text(repository.nameOfActivity[dataBloc.state.activity]);

            }),
            BlocBuilder<TimerCubit, TimerState>(builder: (context, state) {
              return Text(
                '${dataBloc.state.timerCountdown}',
                style: const TextStyle(fontSize: 40),
              );
            }) //bb
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: dataBloc.runTimer,
        tooltip: 'start',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

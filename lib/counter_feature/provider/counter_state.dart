sealed class CounterState {
  const CounterState();
}

class LoadingState extends CounterState {
  const LoadingState();
}

class LoadedState extends CounterState {
  final int count;
  const LoadedState(this.count);
}

class DoneState extends CounterState {
  const DoneState();
}

// import 'package:freezed_annotation/freezed_annotation.dart';

// part 'counter_state.freezed.dart';

// @freezed
// class CounterState with _$CounterState {
//   const factory CounterState.loading() = _Loading;
//   const factory CounterState.loaded(int count) = _Loaded;
//   const factory CounterState.done() = _Done;
// }

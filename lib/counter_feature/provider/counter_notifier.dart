import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'counter_state.dart';

class CounterNotifier extends StateNotifier<CounterState> {
  CounterNotifier() : super(const LoadingState()) {
    _startLoading();
  }

  void _startLoading() {
    state = const LoadingState();
    Future.delayed(const Duration(seconds: 3), () {
      state = const LoadedState(0);
    });
  }

  void increment() {
    if (state case LoadedState s) {
      state = LoadedState(s.count + 1);
    }
  }

  void decrement() {
    if (state case LoadedState s) {
      state = LoadedState(s.count - 1);
    }
  }

  void reset() {
    if (state is LoadedState) {
      state = const LoadedState(0);
    }
  }

  void done() {
    state = const DoneState();
  }

  void restart() {
    _startLoading();
  }
}

// /// Using freezed
// class CounterNotifier extends StateNotifier<CounterState> {
//   CounterNotifier() : super(const CounterState.loading()) {
//     _startLoading();
//   }

//   void _startLoading() {
//     state = const CounterState.loading();
//     Future.delayed(const Duration(seconds: 3), () {
//       state = const CounterState.loaded(0);
//     });
//   }

//   void increment() => state.maybeWhen(
//     loaded: (count) => state = CounterState.loaded(count + 1),
//     orElse: () => null,
//   );

//   void decrement() => state.maybeWhen(
//     loaded: (count) => state = CounterState.loaded(count - 1),
//     orElse: () => null,
//   );

//   void reset() => state.maybeWhen(
//     loaded: (_) => state = const CounterState.loaded(0),
//     orElse: () => null,
//   );

//   void done() => state = const CounterState.done();

//   void restart() => _startLoading();
// }

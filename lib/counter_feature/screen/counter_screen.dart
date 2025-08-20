import 'package:counter_riverpod/counter_feature/provider/counter_notifier.dart';
import 'package:counter_riverpod/counter_feature/provider/counter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterProvider = StateNotifierProvider<CounterNotifier, CounterState>((
  ref,
) {
  return CounterNotifier();
});

/// UI
class CounterScreen extends ConsumerWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(counterProvider);

    // for side effects etc
    ref.listen(counterProvider, (previous, next) {
      if (next is DoneState) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("This is a snackbar!")));
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text("Riverpod State Cycle")),
      body: Center(
        child: switch (state) {
          /// Loading State
          LoadingState() => const CircularProgressIndicator(),

          /// Loaded State
          LoadedState(count: final c) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("$c", style: const TextStyle(fontSize: 48)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("This is a snackbar!")),
                  );
                },
                child: const Text("Show Snackbar"),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => ref.read(counterProvider.notifier).done(),
                child: const Text("Done"),
              ),
            ],
          ),

          /// Done State
          DoneState() => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Restart counter?", style: TextStyle(fontSize: 24)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => ref.read(counterProvider.notifier).restart(),
                child: const Text("Restart"),
              ),
            ],
          ),
        },
      ),

      /// Floating Action Button
      floatingActionButton: state is LoadedState
          ? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () =>
                      ref.read(counterProvider.notifier).decrement(),
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(width: 16),
                FloatingActionButton(
                  onPressed: () =>
                      ref.read(counterProvider.notifier).increment(),
                  child: const Icon(Icons.add),
                ),
                const SizedBox(width: 16),
                FloatingActionButton(
                  onPressed: () => ref.read(counterProvider.notifier).reset(),
                  child: const Icon(Icons.refresh),
                ),
              ],
            )
          : null,
    );
  }
}

/// Using freezed
///

// final counterProvider = StateNotifierProvider<CounterNotifier, CounterState>((
//   ref,
// ) {
//   return CounterNotifier();
// });

// /// UI
// class CounterScreen extends ConsumerWidget {
//   const CounterScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final state = ref.watch(counterProvider);

//     return Scaffold(
//       appBar: AppBar(title: const Text("Riverpod State Cycle")),
//       body: Center(
//         child: state.when(
//           loading: () => const CircularProgressIndicator(),
//           loaded: (c) => Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text("$c", style: const TextStyle(fontSize: 48)),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text("This is a snackbar!")),
//                   );
//                 },
//                 child: const Text("Show Snackbar"),
//               ),
//               const SizedBox(height: 12),
//               ElevatedButton(
//                 onPressed: () => ref.read(counterProvider.notifier).done(),
//                 child: const Text("Done"),
//               ),
//             ],
//           ),
//           done: () => Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text("Restart counter?", style: TextStyle(fontSize: 24)),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () => ref.read(counterProvider.notifier).restart(),
//                 child: const Text("Restart"),
//               ),
//             ],
//           ),
//         ),
//       ),

//       /// Floating Action Button
//       floatingActionButton: state.maybeWhen(
//         loaded: (count) => Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             FloatingActionButton(
//               heroTag: 'dec',
//               onPressed: () => ref.read(counterProvider.notifier).decrement(),
//               child: const Icon(Icons.remove),
//             ),
//             const SizedBox(width: 16),
//             FloatingActionButton(
//               heroTag: 'inc',
//               onPressed: () => ref.read(counterProvider.notifier).increment(),
//               child: const Icon(Icons.add),
//             ),
//             const SizedBox(width: 16),
//             FloatingActionButton(
//               heroTag: 'reset',
//               onPressed: () => ref.read(counterProvider.notifier).reset(),
//               child: const Icon(Icons.refresh),
//             ),
//           ],
//         ),
//         orElse: () => null,
//       ),
//     );
//   }
// }

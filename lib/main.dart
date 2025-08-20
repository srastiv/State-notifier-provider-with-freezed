import 'package:counter_riverpod/counter_feature/screen/counter_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CounterScreen(),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// // Provider (StateNotifier for counter logic)
// class CounterNotifier extends StateNotifier<int> {
//   CounterNotifier() : super(0);

//   void increment() => state++;
//   void decrement() => state--;
//   void reset() => state = 0;
// }

// final counterProvider = StateNotifierProvider<CounterNotifier, int>(
//   (ref) => CounterNotifier(),
// );

// // App
// void main() {
//   runApp(const ProviderScope(child: MyApp()));
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: CounterScreen(),
//     );
//   }
// }

// // UI
// class CounterScreen extends ConsumerWidget {
//   const CounterScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final count = ref.watch(counterProvider);
//     final CounterNotifier notifier = ref.read(counterProvider.notifier);

//     return Scaffold(
//       appBar: AppBar(title: const Text('Riverpod CounterApp')),
//       body: Center(
//         child: Text(
//           '$count',
//           style: const TextStyle(fontSize: 48),
//         ),
//       ),
//       floatingActionButton: Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           FloatingActionButton(
//             heroTag: 'decrement',
//             onPressed: () => notifier.decrement(),
//             child: const Icon(Icons.remove),
//           ),
//           const SizedBox(width: 16),
//           FloatingActionButton(
//             heroTag: 'increment',
//             onPressed: () => notifier.increment(),
//             child: const Icon(Icons.add),
//           ),
//           const SizedBox(width: 16),
//           FloatingActionButton(
//             heroTag: 'reset',
//             onPressed: () => notifier.reset(),
//             child: const Icon(Icons.refresh),
//           ),
//         ],
//       ),
//     );
//   }
// }

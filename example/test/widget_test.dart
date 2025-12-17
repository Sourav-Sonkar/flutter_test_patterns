import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_patterns/flutter_test_patterns.dart';

// Example Contract: Verifies that tapping a FAB increments a counter
class CounterIncrementContract extends InteractionContract {
  CounterIncrementContract() : super('Tapping FAB increments counter');

  @override
  Future<void> verify(WidgetTester tester) async {
    // Verify initial state
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Perform interaction
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify result
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  }
}

void main() {
  testWidgets('Counter App Interaction Test', (WidgetTester tester) async {
    await testInteractionContract(
      tester,
      build: () => const MyApp(),
      contracts: [
        CounterIncrementContract(),
      ],
    );
  });

  testWidgets('Counter App State Matrix Test', (WidgetTester tester) async {
    await testStateMatrix(
      tester,
      'counter_app',
      states: {
        'default': () => const MyApp(),
      },
      verify: (stateName) {
        expect(find.text('0'), findsOneWidget);
      },
    );
  });
}

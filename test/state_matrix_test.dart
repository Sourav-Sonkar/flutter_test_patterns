import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_patterns/state_matrix.dart';

void main() {
  testWidgets('State Matrix Demo', (tester) async {
    await testStateMatrix(
      tester,
      'text_states',
      states: {
        'short': () => const Text('Short'),
        'long': () => const Text('Long text content that might overflow'),
      },
      verify: (stateName) {
         if (stateName == 'short') {
            expect(find.text('Short'), findsOneWidget);
         } else {
            expect(find.text('Long text content that might overflow'), findsOneWidget);
         }
      },
    );
  });
}

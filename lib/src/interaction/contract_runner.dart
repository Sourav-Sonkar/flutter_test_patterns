import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// Represents a single interaction contract that a widget must satisfy.
abstract class InteractionContract {
  final String description;

  const InteractionContract(this.description);

  /// Executes the contract verification.
  Future<void> verify(WidgetTester tester);
}

/// Runs a list of interaction contracts against a widget.
Future<void> testInteractionContract(
  WidgetTester tester, {
  required Widget Function() build,
  required List<InteractionContract> contracts,
}) async {
  for (final contract in contracts) {
    // Isolate each contract execution
    await tester.pumpWidget(build());
    await tester.pumpAndSettle();

    await test(
        'Contract: ${contract.description}',
        () async {
            await contract.verify(tester);
        }
    );
    
    // Cleanup
    await tester.pumpWidget(const SizedBox.shrink());
  }
}

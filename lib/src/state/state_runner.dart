import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../golden/golden_wrapper.dart';

/// Tests a widget across a matrix of states using a custom verification callback.
Future<void> testStateMatrix(
  WidgetTester tester,
  String name, {
  required Map<String, Widget Function()> states,
  required void Function(String stateName) verify,
  bool wrapWithMaterialApp = true,
}) async {
  for (final entry in states.entries) {
    final stateName = entry.key;
    final widgetBuilder = entry.value;

    final widget = widgetBuilder();

    // Pump widget, potentially wrapped for context (like Theme)
    await tester.pumpWidget(
      GoldenWrapper(
        wrapWithMaterialApp: wrapWithMaterialApp,
        // Default small size if not specified, implies component testing
        surfaceSize: const Size(800, 600),
        child: widget,
      ),
    );

    await tester.pumpAndSettle();

    // Run verification
    verify(stateName);

    // Cleanup
    await tester.pumpWidget(const SizedBox.shrink());
  }
}

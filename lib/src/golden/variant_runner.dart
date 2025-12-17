import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'golden_wrapper.dart';

/// Runs golden tests for multiple variants of a widget.
Future<void> goldenVariants(
  WidgetTester tester,
  String name, {
  required Map<String, Widget Function()> variants,
  Size? surfaceSize,
  Color? backgroundColor,
  bool wrapWithMaterialApp = true,
}) async {
  for (final entry in variants.entries) {
    final variantName = entry.key;
    final widgetBuilder = entry.value;

    final widget = widgetBuilder();

    // Pump the widget wrapped in our standard wrapper
    await tester.pumpWidget(
      GoldenWrapper(
        surfaceSize: surfaceSize,
        backgroundColor: backgroundColor,
        wrapWithMaterialApp: wrapWithMaterialApp,
        child: widget,
      ),
    );

    // Wait for any animations to settle (if any, though we aim for deterministic)
    await tester.pumpAndSettle();

    final goldenPath = 'goldens/$name/$variantName.png';

    // Verify golden
    // We expect the Wrapper to match the file.
    // Actually finding by Type GoldenWrapper is safe because we just pumped it.
    await expectLater(
      find.byType(GoldenWrapper),
      matchesGoldenFile(goldenPath),
    );

    // Clear the widget tree to ensure isolation between variants
    // We pump a placeholder to clear the previous widget.
    await tester.pumpWidget(const SizedBox.shrink());
  }
}

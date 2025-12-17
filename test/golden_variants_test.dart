import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_variants/golden_variants.dart';

// reliable custom font loading in tests is tricky without setup, so we used standard widgets
class DemoButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback? onPressed;

  const DemoButton({
    Key? key,
    required this.label,
    required this.color,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: color),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}

void main() {
  testWidgets('DemoButton variants', (tester) async {
    await goldenVariants(
      tester,
      'demo_button',
      variants: {
        'primary': () => const DemoButton(
              label: 'Primary',
              color: Colors.blue,
              onPressed: _dummyAction,
            ),
        'disabled': () => const DemoButton(
              label: 'Disabled',
              color: Colors.grey,
              onPressed: null,
            ),
        'danger': () => const DemoButton(
              label: 'Danger',
              color: Colors.red,
              onPressed: _dummyAction,
            ),
      },
      surfaceSize: const Size(200, 100),
    );
  });
}

void _dummyAction() {}

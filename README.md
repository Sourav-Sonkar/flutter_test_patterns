# golden_variants

A simple, opinionated helper for Flutter golden tests, optimized for design system widgets with multiple visual variants.

## Problem Statement

Writing golden tests for widgets with many states (primary, disabled, error, etc.) often leads to:
- **Boilerplate**: Manually pumping widgets, settling, and matching.
- **Inconsistency**: Different screen sizes, wrappers, or backgrounds across tests.
- **Flakiness**: Leakage of state between variant pumps.

## Solution

`golden_variants` provides a single function that:
1. Pumps each variant in isolation.
2. Wraps it with standard defaults (MaterialApp, Scaffold, white background).
3. Generates deterministic, named golden files.

## Usage

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_variants/golden_variants.dart';

void main() {
  testWidgets('Button variants', (tester) async {
    await goldenVariants(
      tester,
      'button',
      variants: {
        'primary': () => Button.primary(),
        'disabled': () => Button.primary(onPressed: null),
        'icon': () => Button.icon(),
      },
      // Optional overrides
      surfaceSize: Size(400, 100), 
    );
  });
}
```

## Naming Convention

Goldens are generated at:
`goldens/<name>/<variant>.png`

For the example above:
- `goldens/button/primary.png`
- `goldens/button/disabled.png`
- `goldens/button/icon.png`

## Dependencies

Only `flutter_test`. No other external dependencies.

## When NOT to use this package

- If you need complex scenario orchestration (integration tests).
- If you need pixel matching tolerances (defaults to exact match, though `flutter_test` config applies).
- If you rely heavily on Animations (this package pumps and settles, but doesn't offer fine-grained animation control).

# Golden Variants Pattern

File: `package:flutter_test_patterns/golden_variants.dart`

## Problem

Testing a widget that has many visual states (e.g., a button with primary, secondary, disabled, and loading variants) usually results in:
1.  **Boilerplate loops**: Manually iterating over variants.
2.  **Inconsistent environment**: Forgetting to wrap one variant in a `MaterialApp` or set the correct surface size.
3.  **State leakage**: If you don't reset the tester between pumps, state from one variant can affect the next.

## Solution

The `goldenVariants` helper standardizes this process. It takes a map of variants and produces one named golden file per variant.

## Usage

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_patterns/golden_variants.dart';

void main() {
  testWidgets('Button visual regression', (tester) async {
    await goldenVariants(
      tester,
      'button',
      variants: {
        'primary': () => Button.primary(),
        'disabled': () => Button.primary(onPressed: null),
        'icon': () => Button.icon(Icons.add),
      },
      // Optional: enforce a consistent test surface size
      surfaceSize: Size(200, 100),
    );
  });
}
```

## When to use

- Design system components.
- Widgets with distinct "modes" or "types".
- When you want to guarantee isolated rendering for each state.

## When NOT to use

- **Integration tests**: If you need to simulate a user flow across multiple screens.
- **Animation tests**: If you need to verify specific frames of an animation (this helper settles animations automatically).

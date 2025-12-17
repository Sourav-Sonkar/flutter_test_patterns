# Interaction Contract Pattern

File: `package:flutter_test_patterns/interaction_contracts.dart`

## Problem

Reusable widgets often have implicit behavioral contracts that are easy to break but tedious to test repeatedly.
Example:
- "A primary button must fire `onPressed` exactly once when tapped."
- "A disabled button must NOT fire `onPressed` when tapped."

Writing these `await tester.tap(...)` tests for every button variant is repetitive and hides the intent.

## Solution

`testInteractionContract` allows you to define and reuse explicit contracts.

## Usage

First, define your reusable contracts (or stick them in a `test_utils` folder):

```dart
class FiresOnTapOnce extends InteractionContract {
  final VoidCallback mockCallback;
  
  FiresOnTapOnce(this.mockCallback) : super('Fires onTap exactly once');

  @override
  Future<void> verify(WidgetTester tester) async {
    await tester.tap(find.byType(ElevatedButton)); // or generic finder
    expect(mockCallback.callCount, 1);
  }
}
```

Then use them in your tests:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_patterns/interaction_contracts.dart';

void main() {
  testWidgets('Button interaction contracts', (tester) async {
    await testInteractionContract(
      tester,
      build: () => Button.primary(onPressed: mockOnPressed),
      contracts: [
        FiresOnTapOnce(mockOnPressed),
        DoesNotFireWhenDisabled(),
      ],
    );
  });
}
```

## When to use

- When a widget has strictly defined behavioral rules that must hold true across refactors.
- When you have a set of widgets that share common behaviors (e.g., all form fields must validate on blur).

## When NOT to use

- **One-off logic**: If a behavior is unique to a single widget, just write a normal test.

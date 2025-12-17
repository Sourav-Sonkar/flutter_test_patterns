# State Matrix Pattern

File: `package:flutter_test_patterns/state_matrix.dart`

## Problem

Complex widgets (like a User Profile Card) can exist in many states: `loading`, `error`, `guest`, `authenticated_admin`, `authenticated_user`.
It's common to only test the "happy path" and forget the edge cases.

## Solution

`testStateMatrix` forces you to explicitly define the states and runs a verification callback against each. This separates the *setup* of the state from the *verification* logic.

## Usage

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_patterns/state_matrix.dart';

void main() {
  testWidgets('ProfileCard state matrix', (tester) async {
    await testStateMatrix(
      tester,
      'profile_card',
      states: {
        'loading': () => ProfileCard(isLoading: true),
        'error': () => ProfileCard(error: 'Failed'),
        'data': () => ProfileCard(user: User(name: 'Alice')),
      },
      verify: (stateName) {
        if (stateName == 'loading') {
          expect(find.byType(CircularProgressIndicator), findsOneWidget);
        } else if (stateName == 'error') {
          expect(find.text('Failed'), findsOneWidget);
        } else {
          expect(find.text('Alice'), findsOneWidget);
        }
      },
    );
  });
}
```

## When to use

- Widgets with complex state machines.
- When you want to ensure a single assertion logic (like "does not crash") holds true for all states.

## When NOT to use

- If the verification logic varies wildly between states, it might be cleaner to write separate tests.

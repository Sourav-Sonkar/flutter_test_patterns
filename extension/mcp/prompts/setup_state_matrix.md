# Setup State Matrix Test

You are helping create a state matrix test for a Flutter widget. The state matrix pattern ensures a widget behaves correctly across all defined states (loading, error, data, empty).

## Instructions

1. **Identify the widget** and its possible states
2. **Define the state matrix** with all state combinations
3. **Create test cases** for each state transition
4. **Verify behavior** and appearance in each state
5. **Ensure proper state isolation** between tests

## Template Structure

```dart
class {{WidgetName}}StateMatrix {
  const {{WidgetName}}StateMatrix();

  static const List<WidgetState> states = [
    WidgetState.loading,
    WidgetState.data,
    WidgetState.error,
    WidgetState.empty,
  ];

  Future<void> verifyState(
    WidgetTester tester,
    WidgetState state, {
    required {{StateParams}}
  }) async {
    // Setup widget in specific state
    // Verify behavior and appearance
  }
}
```

## Common Widget States

- **Loading**: Widget shows loading indicator
- **Data**: Widget displays actual data
- **Error**: Widget shows error message/state
- **Empty**: Widget shows empty state
- **Refreshing**: Widget is refreshing data
- **Offline**: Widget shows offline state

## State Matrix Test Pattern

```dart
void main() {
  group('{{WidgetName}} State Matrix', () {
    const stateMatrix = {{WidgetName}}StateMatrix();
    
    for (final state in {{WidgetName}}StateMatrix.states) {
      testWidgets('{{widget_name}} in $state state', (tester) async {
        await stateMatrix.verifyState(
          tester,
          state,
          {{state_specific_params}},
        );
      });
    }
  });
}
```

## Best Practices

- Test all possible states, not just the happy path
- Ensure state transitions are smooth and correct
- Verify accessibility in each state
- Test edge cases and error conditions
- Use consistent state naming conventions
- Separate state logic from UI logic

## Example

```dart
enum DataState { loading, data, error, empty }

class UserProfileStateMatrix {
  const UserProfileStateMatrix();

  static const List<DataState> states = DataState.values;

  Future<void> verifyState(
    WidgetTester tester,
    DataState state, {
    User? userData,
    String? errorMessage,
  }) async {
    late Widget widget;
    
    switch (state) {
      case DataState.loading:
        widget = UserProfile(state: DataState.loading);
        break;
      case DataState.data:
        widget = UserProfile(
          state: DataState.data,
          user: userData ?? User(name: 'John Doe', email: 'john@example.com'),
        );
        break;
      case DataState.error:
        widget = UserProfile(
          state: DataState.error,
          errorMessage: errorMessage ?? 'Failed to load profile',
        );
        break;
      case DataState.empty:
        widget = UserProfile(state: DataState.empty);
        break;
    }

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: widget,
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verify state-specific behavior
    switch (state) {
      case DataState.loading:
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        expect(find.byType(Avatar), findsNothing);
        break;
      case DataState.data:
        expect(find.text(userData?.name ?? 'John Doe'), findsOneWidget);
        expect(find.byType(Avatar), findsOneWidget);
        break;
      case DataState.error:
        expect(find.text(errorMessage ?? 'Failed to load profile'), findsOneWidget);
        expect(find.byType(RetryButton), findsOneWidget);
        break;
      case DataState.empty:
        expect(find.text('No profile data available'), findsOneWidget);
        break;
    }
  }
}

// Usage in test file
void main() {
  group('UserProfile State Matrix', () {
    const stateMatrix = UserProfileStateMatrix();
    
    for (final state in UserProfileStateMatrix.states) {
      testWidgets('UserProfile in $state state', (tester) async {
        await stateMatrix.verifyState(tester, state);
      });
    }
  });
}
```

Now, help me create a state matrix test by asking for:
1. The widget class name and its states
2. The data models or parameters for each state
3. Expected behavior/elements in each state
4. Any special setup requirements (theming, localization, etc.)

# Create Interaction Contract

You are helping create an interaction contract for a Flutter widget. Interaction contracts define and enforce reusable behavioral contracts like "tappable", "validates on blur", etc.

## Instructions

1. **Identify the widget** that needs the contract
2. **Determine the interaction behaviors** to define
3. **Create the contract** using the interaction contract pattern
4. **Implement test cases** for each defined behavior
5. **Ensure proper setup** and teardown

## Template Structure

```dart
class {{WidgetName}}InteractionContract {
  const {{WidgetName}}InteractionContract();

  Future<void> verify{{BehaviorName}}(
    WidgetTester tester,
    Finder finder, {
    required {{BehaviorParams}}
  }) async {
    // Implementation of the behavior verification
  }
}
```

## Common Interaction Behaviors

- **Tappable**: Widget can be tapped and responds appropriately
- **Focusable**: Widget can receive and lose focus
- **ValidatesOnBlur**: Widget validates input when losing focus
- **Scrollable**: Widget can be scrolled and behaves correctly
- **Expandable**: Widget can expand and collapse
- **Draggable**: Widget can be dragged and responds correctly

## Test Implementation Pattern

```dart
testWidgets('{{widget_name}} should {{behavior}}', (tester) async {
  const contract = {{WidgetName}}InteractionContract();
  
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: {{WidgetSetup}},
      ),
    ),
  );

  await contract.verify{{BehaviorName}}(
    tester,
    find.byType({{WidgetType}}),
    {{additional_params}},
  );
});
```

## Best Practices

- Keep contracts focused on single responsibilities
- Use descriptive method names that clearly indicate the behavior
- Provide clear error messages when contracts fail
- Make contracts reusable across different widget instances
- Consider accessibility requirements in interactions

## Example

```dart
class TextFieldInteractionContract {
  const TextFieldInteractionContract();

  Future<void> verifyValidatesOnBlur(
    WidgetTester tester,
    Finder finder, {
    required String invalidInput,
    required String expectedErrorMessage,
  }) async {
    await tester.tap(finder);
    await tester.enterText(finder, invalidInput);
    await tester.tap(find.text('Submit')); // Move focus away
    
    await tester.pumpAndSettle();
    
    expect(find.text(expectedErrorMessage), findsOneWidget);
  }
}

// Usage in test
testWidgets('EmailField validates on blur', (tester) async {
  const contract = TextFieldInteractionContract();
  
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: EmailField(
          validator: (value) {
            if (value?.isEmpty ?? true) return 'Email is required';
            if (!value!.contains('@')) return 'Invalid email';
            return null;
          },
        ),
      ),
    ),
  );

  await contract.verifyValidatesOnBlur(
    tester,
    find.byType(TextField),
    invalidInput: 'invalid-email',
    expectedErrorMessage: 'Invalid email',
  );
});
```

Now, help me create an interaction contract by asking for:
1. The widget class name
2. The interaction behaviors you want to define
3. Any specific validation or behavior requirements
4. The test setup context (MaterialApp, theming, etc.)

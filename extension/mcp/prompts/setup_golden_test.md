# Setup Golden Variants Test

You are helping create a golden variants test for a Flutter widget. The golden variants pattern allows testing multiple visual states of a widget in a single test block.

## Instructions

1. **Identify the widget** to be tested and its import path
2. **Determine the key variants** to test (e.g., primary, disabled, hover, loading, error states)
3. **Create the test structure** using `goldenVariants` helper
4. **Set up proper widget wrapping** (MaterialApp, Theme, etc.)
5. **Define descriptive variant names** that clearly indicate the state

## Template Structure

```dart
testWidgets('{{widget_name}} variants', (tester) async {
  await goldenVariants(
    tester,
    '{{test_name_prefix}}',
    variants: {
      {{variants_mapping}}
    },
  );
});
```

## Common Variants to Consider

- **Primary/Default**: Normal state
- **Disabled**: Widget is disabled
- **Loading**: Widget shows loading state
- **Error**: Widget shows error state
- **Hover**: Widget is hovered (if applicable)
- **Pressed**: Widget is pressed (if applicable)
- **Selected**: Widget is selected (if applicable)

## Best Practices

- Use descriptive variant names
- Ensure consistent widget sizing across variants
- Wrap widgets in MaterialApp for proper theming
- Use semantic labels for accessibility
- Consider different screen sizes if responsive

## Example

```dart
testWidgets('CustomButton variants', (tester) async {
  await goldenVariants(
    tester,
    'custom_button',
    variants: {
      'primary': () => MaterialApp(
        home: Scaffold(
          body: CustomButton(
            onPressed: () {},
            child: Text('Click me'),
          ),
        ),
      ),
      'disabled': () => MaterialApp(
        home: Scaffold(
          body: CustomButton(
            onPressed: null,
            child: Text('Disabled'),
          ),
        ),
      ),
      'loading': () => MaterialApp(
        home: Scaffold(
          body: CustomButton.loading(
            child: Text('Loading...'),
          ),
        ),
      ),
    },
  );
});
```

Now, help me create a golden variants test by asking for:
1. The widget class name and import path
2. The variants you want to test
3. Any specific setup requirements (theming, localization, etc.)

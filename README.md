# Flutter Test Patterns

A toolbox of common, senior-level widget testing patterns for Flutter.

This package provides **opt-in** helpers to reduce boilerplate in your tests. It is **NOT** a testing framework. It does not impose a specific architecture or base class.

## Philosophy

- **Explicit is better than implicit.** Helpers should not hide what they are doing.
- **Composition over inheritance.** No `BaseTest` classes.
- **Isolation.** State should not leak between tests or variants.

## Patterns

| Pattern | Purpose |
| :--- | :--- |
| [**Golden Variants**](doc/patterns/golden_variants.md) | Generate multiple visual variants (primary, hover, disabled) in a single test block with deterministic output. |
| [**Interaction Contracts**](doc/patterns/interaction_contracts.md) | Define and enforce reusable behavioral contracts (e.g., "tappable", "validates on blur"). |
| [**State Matrix**](doc/patterns/state_matrix.md) | Ensure a widget behaves correctly across all defined states (loading, error, data, empty). |

## Installation

```yaml
dev_dependencies:
  flutter_test_patterns:
    path: . # Local path or git url
```

## Quick Example (Golden Variants)

```dart
testWidgets('Button variants', (tester) async {
  await goldenVariants(
    tester,
    'button',
    variants: {
      'primary': () => Button.primary(),
      'disabled': () => Button.disabled(),
    },
  );
});
```

See [doc/patterns/](doc/patterns/) for detailed guides on each pattern.

## Contributing

Contributions are welcome! Please feel free to open an issue or submit a PR.

## License

MIT

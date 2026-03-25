# Flutter Test Patterns

[![Pub Version](https://img.shields.io/pub/v/flutter_test_patterns)](https://pub.dev/packages/flutter_test_patterns)
[![Agent Skill](https://img.shields.io/badge/Agent%20Skill-SKILL.md-blue)](https://skillsmp.com)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://github.com/Sourav-Sonkar/flutter_test_patterns/pulls)
[![Flutter](https://img.shields.io/badge/Flutter-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Testing](https://img.shields.io/badge/Testing-Widget%20Tests-02569B)](https://flutter.dev/testing)
[![Golden Tests](https://img.shields.io/badge/Golden-Tests-FFD700)](https://flutter.dev/testing#golden-tests)

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

## AI Agent Skill

Use `flutter_test_patterns` directly inside Claude Code, Cursor, GitHub Copilot, Windsurf, and 39+ AI agents:

```bash
npx skills add Sourav-Sonkar/flutter_test_patterns
```

Then just ask your AI: *"Write widget tests for this Flutter component"*

## License

MIT

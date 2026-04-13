# Flutter Test Patterns

[![Pub Version](https://img.shields.io/pub/v/flutter_test_patterns)](https://pub.dev/packages/flutter_test_patterns)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://github.com/Sourav-Sonkar/flutter_test_patterns/pulls)
[![Flutter](https://img.shields.io/badge/Flutter-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Testing](https://img.shields.io/badge/Testing-Widget%20Tests-02569B)](https://flutter.dev/testing)
[![Golden Tests](https://img.shields.io/badge/Golden-Tests-FFD700)](https://flutter.dev/testing#golden-tests)

**Pattern-based testing system for Flutter**

Structured, reusable testing patterns that scale with your application.

---

## The Problem

Flutter tests become unmanageable at scale:

- **Repetitive boilerplate** in widget and golden tests
- **Inconsistent structure** across teams and files
- **Missing edge cases** and incomplete state coverage
- **Hard-to-maintain** test suites that resist refactoring

Writing tests manually works for small apps, but it breaks down as codebases grow. Teams end up with fragmented testing practices, inconsistent coverage, and suites that are expensive to maintain.

---

## The Solution

**Pattern-based testing.**

Instead of writing tests from scratch each time, use codified, reusable patterns that enforce consistency and completeness.

These patterns were developed while building a large-scale design system at Tata Neu, where maintaining consistent test coverage across hundreds of components was a critical challenge.

This package is not a collection of helpers—it's a systematic approach to Flutter testing.

---

## Core Patterns

### Golden Variants

Generate multiple visual states (primary, hover, disabled, error) in a single test block with deterministic file naming.

**Before:**
```dart
testWidgets('Button primary', (tester) async {
  await tester.pumpWidget(Button.primary());
  await expectLater(
    find.byType(Button),
    matchesGoldenFile('button.primary.png'),
  );
});

testWidgets('Button disabled', (tester) async {
  await tester.pumpWidget(Button.disabled());
  await expectLater(
    find.byType(Button),
    matchesGoldenFile('button.disabled.png'),
  );
});

// Repeat for every variant...
```

**After:**
```dart
testWidgets('Button variants', (tester) async {
  await goldenVariants(
    tester,
    'button',
    variants: {
      'primary': () => Button.primary(),
      'disabled': () => Button.disabled(),
      'hover': () => Button.primary(isHovered: true),
    },
  );
});
```

### State Matrix

Test all UI states (loading, error, data, empty) in a structured matrix to ensure complete coverage.

**Before:**
```dart
testWidgets('DataCard loading', (tester) async {
  await tester.pumpWidget(DataCard(state: LoadingState()));
  expect(find.byType(CircularProgressIndicator), findsOneWidget);
});

testWidgets('DataCard error', (tester) async {
  await tester.pumpWidget(DataCard(state: ErrorState('Failed')));
  expect(find.text('Failed'), findsOneWidget);
});

// Easy to miss states, inconsistent structure...
```

**After:**
```dart
testWidgets('DataCard state matrix', (tester) async {
  await stateMatrix(
    tester,
    DataCard,
    states: {
      'loading': () => DataCard(state: LoadingState()),
      'error': () => DataCard(state: ErrorState('Failed')),
      'data': () => DataCard(state: DataState(User(name: 'John'))),
      'empty': () => DataCard(state: EmptyState()),
    },
    assertions: (state, widget) {
      switch (state) {
        case 'loading':
          expect(find.byType(CircularProgressIndicator), findsOneWidget);
          break;
        case 'error':
          expect(find.text('Failed'), findsOneWidget);
          break;
        // ...
      }
    },
  );
});
```

### Interaction Contracts

Define reusable behavioral rules (tappable, validates on blur, scrolls) and apply them consistently.

**Before:**
```dart
testWidgets('Button is tappable', (tester) async {
  bool tapped = false;
  await tester.pumpWidget(Button(
    onTap: () => tapped = true,
  ));
  await tester.tap(find.byType(Button));
  expect(tapped, true);
});

// Repeated across every tappable widget...
```

**After:**
```dart
testWidgets('Button interaction contract', (tester) async {
  await tappableContract(
    tester,
    () => Button(onTap: () {}),
  );
});
```

---

## Benefits

- **Eliminate boilerplate** - Write less code, test more
- **Consistent structure** - Every test follows the same pattern
- **Complete coverage** - Patterns enforce edge case testing
- **Scalable** - Works for small apps and large design systems
- **No framework lock-in** - Opt-in patterns, no base classes required
- **Deterministic golden tests** - Predictable file naming, no flakiness

---

## AI Integration

This package includes an AI agent skill for code generation tools (Claude Code, Cursor, GitHub Copilot, Windsurf, and others).

```bash
npx skills add Sourav-Sonkar/flutter_test_patterns
```

The AI generates tests using these patterns, ensuring consistency even when using AI assistance.

---

## Getting Started

Add to your `pubspec.yaml`:

```yaml
dev_dependencies:
  flutter_test_patterns: ^latest_version
```

Import and use patterns in your tests:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_patterns/flutter_test_patterns.dart';

void main() {
  testWidgets('My component variants', (tester) async {
    await goldenVariants(
      tester,
      'my_component',
      variants: {
        'default': () => MyComponent(),
        'active': () => MyComponent(active: true),
      },
    );
  });
}
```

See [doc/patterns/](doc/patterns/) for detailed documentation.

---

## Who Is This For?

- **Teams building design systems** - Enforce consistent testing patterns across components
- **Large Flutter applications** - Scale test coverage without scaling boilerplate
- **Projects with golden tests** - Manage visual regression testing systematically
- **Teams prioritizing quality** - Ensure complete state and interaction coverage

---

## License

MIT

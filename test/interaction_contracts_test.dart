import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_patterns/interaction_contracts.dart';

// --- Test Widgets & Contracts ---

class TappableWidget extends StatelessWidget {
  final VoidCallback onTap;
  final bool enabled;

  const TappableWidget({Key? key, required this.onTap, this.enabled = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(color: enabled ? Colors.blue : Colors.grey, width: 50, height: 50),
    );
  }
}

class FiresOnTapOnce extends InteractionContract {
  final VoidCallback mockCallback;
  
  const FiresOnTapOnce(this.mockCallback) : super('Fires onTap exactly once');

  @override
  Future<void> verify(WidgetTester tester) async {
    await tester.tap(find.byType(TappableWidget));
    // In a real scenario, we might use mockito or check a boolean
  }
}

void main() {
  testWidgets('Interaction Contracts Demo', (tester) async {
    int tapCount = 0;
    
    await testInteractionContract(
      tester,
      build: () => MaterialApp(
        home: TappableWidget(onTap: () => tapCount++),
      ),
      contracts: [
        // Ad-hoc contract for this test
        _FiresTap(
             () {
                expect(tapCount, 1);
                tapCount = 0; // Reset
             },
        ),
      ],
    );
  });
}

class _FiresTap extends InteractionContract {
   final VoidCallback verifyCallback;
   
   _FiresTap(this.verifyCallback) : super('Increments tap count');
   
   @override
   Future<void> verify(WidgetTester tester) async {
     await tester.tap(find.byType(TappableWidget));
     verifyCallback();
   }
}

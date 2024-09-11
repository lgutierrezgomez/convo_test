import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:convo_test/presentation/pages/widgets/input_widget.dart';

// This test verifies that the form works, captures the input, and triggers the correct action.

void main() {
  testWidgets('InputWidget displays and submits form correctly', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: InputWidget(
          onSubmit: (latitude, longitude) {
            expect(latitude, 52.52);
            expect(longitude, 13.41);
          },
        ),
      ),
    ));

    // Find the input fields and button
    final latitudeField = find.byKey(const Key('latitudeField'));
    final longitudeField = find.byKey(const Key('longitudeField'));
    final submitButton = find.byType(ElevatedButton);

    // Enter text into the fields
    await tester.enterText(latitudeField, '52.52');
    await tester.enterText(longitudeField, '13.41');

    // Tap the submit button
    await tester.tap(submitButton);

    // Rebuild the widget to process the button press
    await tester.pump();

    // Verify that the values have been passed to the callback correctly
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:convo_test/presentation/pages/widgets/report_list_widget.dart';
import 'package:convo_test/domain/entities/report_entity.dart';

// This test checks that the horizontal list is populated with temperature data correctly.

void main() {
  testWidgets('ReportListWidget displays temperature and time correctly', (WidgetTester tester) async {
    // Create mock data for the test
    const mockReport = Report(
      latitude: 52.52,
      longitude: 13.41,
      timezone: 'America/Los_Angeles',
      elevation: 15,
      hourly: Hourly(
        temperature_2m: [15.0, 17.0, 18.0],
        time: ['2024-09-10T01:00', '2024-09-10T02:00', '2024-09-10T03:00'],
      ),
    );

    // Build the widget
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ReportListWidget(
                temperatures: mockReport.hourly.temperature_2m,
                times: mockReport.hourly.time,
              ),
            ],
          ),
        ),
      ),
    ));

    // Verify the list view is displayed with the correct items
    expect(find.byType(ListView), findsOneWidget);
    expect(find.text('Date: 2024-09'), findsExactly(3));
    expect(find.text('Time: 01:00'), findsOneWidget);
    expect(find.text('15.0°C'), findsOneWidget);
  });
}

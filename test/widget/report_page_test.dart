import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:convo_test/domain/entities/report_entity.dart';
import 'package:convo_test/presentation/bloc/report_state.dart';
import 'package:convo_test/presentation/pages/report_page.dart';
import 'package:convo_test/presentation/bloc/report_bloc.dart';
import 'report_page_test.mocks.dart';

// This test verifies the UI behavior for loading, loaded, and error states

@GenerateNiceMocks([MockSpec<ReportBloc>()])
void main() {
  late MockReportBloc mockBloc;

  setUp(() {
    mockBloc = MockReportBloc();
  });

  testWidgets('ReportPage displays loading indicator', (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(ReportLoading());

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<ReportBloc>(
          create: (_) => mockBloc,
          child: ReportPage(),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('ReportPage displays report when loaded', (WidgetTester tester) async {
    const mockReport = Report(
      latitude: 52.52,
      longitude: 13.41,
      timezone: 'America/Los_Angeles',
      elevation: 15,
      hourly: Hourly(
        temperature_2m: [15.0, 17.0],
        time: ['2024-09-10T01:00', '2024-09-10T02:00'],
      ),
    );

    when(mockBloc.state).thenReturn(ReportLoaded(mockReport));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<ReportBloc>(
          create: (_) => mockBloc,
          child: ReportPage(),
        ),
      ),
    );

    expect(find.text('Time: 01:00'), findsOneWidget);
  });

  testWidgets('ReportPage displays error message', (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(ReportError('Failed to load report'));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<ReportBloc>(
          create: (_) => mockBloc,
          child: ReportPage(),
        ),
      ),
    );

    expect(find.text('Error: Failed to load report'), findsOneWidget);
  });
}

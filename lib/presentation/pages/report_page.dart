import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/report_bloc.dart';
import '../bloc/report_event.dart';
import '../bloc/report_state.dart';
import 'widgets/input_widget.dart';
import 'widgets/report_list_widget.dart';

class ReportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Report Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            InputWidget(
              onSubmit: (latitude, longitude) {
                context.read<ReportBloc>().add(
                    GetReportEvent(latitude: latitude, longitude: longitude));
              },
            ),
            const SizedBox(height: 24.0),

            // Display the result using BLoC
            BlocBuilder<ReportBloc, ReportState>(
              builder: (context, state) {
                if (state is ReportLoading) {
                  return const CircularProgressIndicator();
                } else if (state is ReportLoaded) {
                  return ReportListWidget(
                    times: state.report.hourly.time,
                    temperatures: state.report.hourly.temperature_2m,
                  );
                } else if (state is ReportInitial) {
                  return const Text(
                      'Enter a location coordinates to get a weather report for today');
                } else if (state is ReportError) {
                  return Text('Error: ${state.message}');
                }
                return const SizedBox.shrink(); // Empty space if no action yet
              },
            ),
          ],
        ),
      ),
    );
  }
}

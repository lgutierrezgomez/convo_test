import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReportListWidget extends StatelessWidget {
  final List<String> times;
  final List<double> temperatures;

  const ReportListWidget({
    Key? key,
    required this.times,
    required this.temperatures,
  }) : super(key: key);

  Map<String, String> _parseDateTime(String dateTimeString) {
    DateTime parsedDateTime = DateTime.parse(dateTimeString);
    String formattedDate = DateFormat('yyyy-MM').format(parsedDateTime);
    String formattedTime = DateFormat('HH:mm').format(parsedDateTime);
    return {'date': formattedDate, 'time': formattedTime};
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: times.length,
        itemBuilder: (context, index) {
          final dateTime = _parseDateTime(times[index]);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              width: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.blueAccent.withOpacity(0.1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        'Date: ${dateTime['date']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Flexible(
                        child: Text(
                          'Time: ${dateTime['time']}',
                          style: const TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                    ),
                    const SizedBox(height: 8.0),
                    Flexible(
                      child: Text(
                        '${temperatures[index]}°C',
                        style: const TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

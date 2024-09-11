import 'package:flutter_test/flutter_test.dart';
import 'package:convo_test/domain/entities/report_entity.dart';

void main() {
  group('Report', () {
    const reportJson = {
      'latitude': 37.7749,
      'longitude': -122.4194,
      'timezone': 'America/Los_Angeles',
      'elevation': 15.0,
      'hourly': {
        'temperature_2m': [15.0, 17.0],
        'time': ['2024-09-10T01:00', '2024-09-10T02:00'],
      }
    };

    test('fromJson should return a valid Report instance', () {
      // Act
      final report = Report.fromJson(reportJson);

      // Assert
      expect(report.latitude, 37.7749);
      expect(report.longitude, -122.4194);
      expect(report.timezone, 'America/Los_Angeles');
      expect(report.elevation, 15.0);
      expect(report.hourly.temperature_2m, [15.0, 17.0]);
      expect(report.hourly.time, ['2024-09-10T01:00', '2024-09-10T02:00']);
    });

    test('toJson should return a valid JSON map', () {
      // Arrange
      final hourly = Hourly(
        temperature_2m: [15.0, 17.0],
        time: ['2024-09-10T01:00', '2024-09-10T02:00'],
      );
      final report = Report(
        latitude: 37.7749,
        longitude: -122.4194,
        timezone: 'America/Los_Angeles',
        elevation: 15.0,
        hourly: hourly,
      );

      // Act
      final json = report.toJson();

      // Assert
      expect(json['latitude'], 37.7749);
      expect(json['longitude'], -122.4194);
      expect(json['timezone'], 'America/Los_Angeles');
      expect(json['elevation'], 15.0);
      expect(json['hourly']['temperature_2m'], [15.0, 17.0]);
      expect(json['hourly']['time'], ['2024-09-10T01:00', '2024-09-10T02:00']);
    });
  });
}

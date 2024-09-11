import 'package:dio/dio.dart';
import '../../../domain/entities/report_entity.dart';

abstract class RemoteReportDataSource {
  Future<Report> fetchReport(double latitude, double longitude);
}

class RemoteReportDataSourceImpl implements RemoteReportDataSource {
  final Dio dio;

  RemoteReportDataSourceImpl(this.dio);

  @override
  Future<Report> fetchReport(double latitude, double longitude) async {
    final response = await dio.get(
      'https://api.open-meteo.com/v1/forecast',
      queryParameters: {
        'latitude': latitude,
        'longitude': longitude,
        'hourly': 'temperature_2m',
        'forecast_days': '1',
      },
    );

    if (response.statusCode == 200) {
      return Report.fromJson(response.data);
    } else {
      throw Exception('Failed to load weather report');
    }
  }
}

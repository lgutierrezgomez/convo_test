import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../../domain/entities/report_entity.dart';

abstract class LocalReportDataSource {
  Future<Report?> getReportFromCache(double latitude, double longitude);
  Future<void> cacheReport(double latitude, double longitude, Report report);
}

class LocalReportDataSourceImpl implements LocalReportDataSource {
  final SharedPreferences prefs;

  LocalReportDataSourceImpl(this.prefs);

  @override
  Future<Report?> getReportFromCache(double latitude, double longitude) async {
    final cacheKey = '$latitude+$longitude';
    if (prefs.containsKey(cacheKey)) {
      final cachedReportJson = prefs.getString(cacheKey);
      if (cachedReportJson != null) {
        return Report.fromJson(jsonDecode(cachedReportJson));
      }
    }
    return null;
  }

  @override
  Future<void> cacheReport(double latitude, double longitude, Report report) async {
    final cacheKey = '$latitude+$longitude';
    await prefs.setString(cacheKey, jsonEncode(report.toJson()));
  }
}

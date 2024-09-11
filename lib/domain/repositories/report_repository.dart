import '../entities/report_entity.dart';

abstract class ReportRepository {
  Future<Report> getReport(double latitude, double longitude);
}
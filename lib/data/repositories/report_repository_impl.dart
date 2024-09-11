import '../datasources/local/report_local_datasource.dart';
import '../datasources/remote/report_remote_datasource.dart';
import '../../domain/entities/report_entity.dart';
import '../../domain/repositories/report_repository.dart';

class ReportRepositoryImpl implements ReportRepository {
  final RemoteReportDataSource remoteDataSource;
  final LocalReportDataSource localDataSource;

  ReportRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<Report> getReport(double latitude, double longitude) async {
    // Check local cache first
    final cachedReport = await localDataSource.getReportFromCache(latitude, longitude);
    if (cachedReport != null) {
      print('Data fetched from cache');
      return cachedReport;
    }

    // If no cache, fetch from remote
    print('Data fetched from API');
    final report = await remoteDataSource.fetchReport(latitude, longitude);

    // Cache the result
    await localDataSource.cacheReport(latitude, longitude, report);

    return report;
  }
}

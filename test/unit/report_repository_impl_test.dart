import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:convo_test/data/datasources/local/report_local_datasource.dart';
import 'package:convo_test/data/datasources/remote/report_remote_datasource.dart';
import 'package:convo_test/data/repositories/report_repository_impl.dart';
import 'package:convo_test/domain/entities/report_entity.dart';
import 'report_repository_impl_test.mocks.dart';

@GenerateMocks([RemoteReportDataSource, LocalReportDataSource])
void main() {
  late MockRemoteReportDataSource mockRemoteDataSource;
  late MockLocalReportDataSource mockLocalDataSource;
  late ReportRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockRemoteReportDataSource();
    mockLocalDataSource = MockLocalReportDataSource();
    repository = ReportRepositoryImpl(mockRemoteDataSource, mockLocalDataSource);
  });

  const double latitude = 37.7749;
  const double longitude = -122.4194;

  const mockReport = Report(
    latitude: 37.7749,
    longitude: -122.4194,
    timezone: 'America/Los_Angeles',
    elevation: 15,
    hourly: Hourly(
      temperature_2m: [15.0, 17.0],
      time: ['2024-09-10T01:00', '2024-09-10T02:00'],
    ),
  );

  group('getReport', () {
    test('should return cached report when available', () async {
      // Arrange: Local cache contains the report
      when(mockLocalDataSource.getReportFromCache(latitude, longitude))
          .thenAnswer((_) async => mockReport);

      // Act: Call the repository
      final result = await repository.getReport(latitude, longitude);

      // Assert: The result should be fetched from the cache, no remote call
      verify(mockLocalDataSource.getReportFromCache(latitude, longitude));
      verifyNever(mockRemoteDataSource.fetchReport(any, any));
      expect(result, mockReport);
    });

    test('should fetch from remote when cache is not available', () async {
      // Arrange: Local cache is empty, so we fetch from remote
      when(mockLocalDataSource.getReportFromCache(latitude, longitude))
          .thenAnswer((_) async => null);
      when(mockRemoteDataSource.fetchReport(latitude, longitude))
          .thenAnswer((_) async => mockReport);

      // Act: Call the repository
      final result = await repository.getReport(latitude, longitude);

      // Assert: The result should be fetched from the remote source
      verify(mockLocalDataSource.getReportFromCache(latitude, longitude));
      verify(mockRemoteDataSource.fetchReport(latitude, longitude));
      verify(mockLocalDataSource.cacheReport(latitude, longitude, mockReport));
      expect(result, mockReport);
    });

    test('should throw an exception when both cache and remote fail', () async {
      // Arrange: Both cache and remote fail
      when(mockLocalDataSource.getReportFromCache(latitude, longitude))
          .thenAnswer((_) async => null);
      when(mockRemoteDataSource.fetchReport(latitude, longitude))
          .thenThrow(Exception('Failed to fetch report'));

      // Act & Assert: Expect an exception when trying to fetch data
      expect(
            () async => await repository.getReport(latitude, longitude),
        throwsException,
      );
    });
  });
}

import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';

import 'package:convo_test/data/repositories/report_repository_impl.dart';
import 'package:convo_test/domain/entities/report_entity.dart';
import 'package:convo_test/domain/usecases/get_report_usecase.dart';
import 'domain_usecase_test.mocks.dart';


@GenerateMocks([ReportRepositoryImpl])
void main() {
  late MockReportRepositoryImpl mockRepositoryImpl;
  late GetReportUseCase useCase;

  setUp(() {
    mockRepositoryImpl = MockReportRepositoryImpl();
    useCase = GetReportUseCase(mockRepositoryImpl);
  });

  group('GetReportUseCase', () {
    final double latitude = 37.7749;
    final double longitude = -122.4194;
    final report = Report(
      latitude: latitude,
      longitude: longitude,
      timezone: 'America/Los_Angeles',
      elevation: 15,
      hourly: Hourly(
        temperature_2m: [15.0, 17.0],
        time: ['2024-09-10T01:00', '2024-09-10T02:00'],
      ),
    );

    test('should return a report when the repository call is successful', () async {
      // Arrange
      when(mockRepositoryImpl.getReport(latitude, longitude))
          .thenAnswer((_) async => report);

      // Act
      final result = await useCase.execute(latitude, longitude);

      // Assert
      expect(result, equals(Right(report)));
      verify(mockRepositoryImpl.getReport(latitude, longitude));
      verifyNoMoreInteractions(mockRepositoryImpl);
    });

    test('should return a Failure when the repository call fails', () async {
      // Arrange
      when(mockRepositoryImpl.getReport(latitude, longitude))
          .thenThrow(Exception('Failed to load report'));

      // Act
      final result = await useCase.execute(latitude, longitude);

      // Assert
      expect(result, equals(Left(Failure('Exception: Failed to load report'))));
      verify(mockRepositoryImpl.getReport(latitude, longitude));
      verifyNoMoreInteractions(mockRepositoryImpl);
    });
  });
}

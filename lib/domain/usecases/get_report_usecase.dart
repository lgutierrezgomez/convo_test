import 'package:dartz/dartz.dart';
import '../entities/report_entity.dart';
import '../repositories/report_repository.dart';

class Failure {
  final String message;
  Failure(this.message);
}

class GetReportUseCase {
  final ReportRepository repository;

  GetReportUseCase(this.repository);

  Future<Either<Failure, Report>> execute(double latitude, double longitude) async {
    try {
      final report = await repository.getReport(latitude, longitude);
      return Right(report); // Return a Right instance of Either on success
    } catch (error) {
      return Left(Failure(error.toString())); // Return a Left instance of Either on failure
    }
  }
}
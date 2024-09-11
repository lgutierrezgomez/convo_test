import 'package:equatable/equatable.dart';

abstract class ReportEvent extends Equatable {
  const ReportEvent();

  @override
  List<Object> get props => [];
}

class GetReportEvent extends ReportEvent {
  final double latitude;
  final double longitude;

  const GetReportEvent({required this.latitude, required this.longitude});

  @override
  List<Object> get props => [latitude, longitude];
}

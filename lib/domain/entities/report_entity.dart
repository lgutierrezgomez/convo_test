import 'package:json_annotation/json_annotation.dart';

part 'report_entity.g.dart';

@JsonSerializable()
class Report {
    final double latitude;
    final double longitude;
    final String timezone;
    final double elevation;
    final Hourly hourly;

    const Report({
      required this.latitude,
      required this.longitude,
      required this.timezone,
      required this.elevation,
      required this.hourly,
    });

factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);

Map<String, dynamic> toJson() => _$ReportToJson(this);
}

@JsonSerializable()
class Hourly {
  final List<String> time;
  final List<double> temperature_2m;

  const Hourly({
    required this.time,
    required this.temperature_2m,
});

  factory Hourly.fromJson(Map<String, dynamic> json) => _$HourlyFromJson(json);
  Map<String, dynamic> toJson() => _$HourlyToJson(this);
}
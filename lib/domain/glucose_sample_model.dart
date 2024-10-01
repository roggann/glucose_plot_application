import 'package:equatable/equatable.dart';

class GlucoseSample extends Equatable {
  final String value, unit;
  final DateTime timestamp;

  const GlucoseSample({
    required this.value,
    required this.unit,
    required this.timestamp,
  });

  factory GlucoseSample.fromJson(Map<String, dynamic> json) => GlucoseSample(
        value: json["value"],
        unit: json["unit"],
        timestamp: DateTime.parse(json["timestamp"]),
      );

  @override
  List<Object?> get props => [value, unit, timestamp,];

}


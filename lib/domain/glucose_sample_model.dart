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
        timestamp: DateTime.fromMillisecondsSinceEpoch(json["timestamp"] * 1000),
      );

  @override
  List<Object?> get props => [value, unit, timestamp,];

}


import 'package:equatable/equatable.dart';
import 'package:glucose_plot_application/presentation/state/glucose_samples_async_notifier.dart';

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
  List<Object?> get props => [
        value,
        unit,
        timestamp,
      ];
}

extension UpcomingSessionDate on List<GlucoseSample> {
  List<GlucoseSample>? listOfSamplesBetweenTwoDates(DateFilterOptions dates) => where(
        (element) => (element.timestamp.isAfter(dates.startDateTime) && element.timestamp.isBefore(dates.endDatetime)),
      ).toList();


}

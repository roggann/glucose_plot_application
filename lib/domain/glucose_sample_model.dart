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
        (element) => ((element.timestamp.isAfter(dates.startDateTime) && element.timestamp.isBefore(dates.endDatetime))||(element.timestamp ==dates.endDatetime)||(element.timestamp ==dates.startDateTime)),
      ).toList();

  double minimumGlucoseValue() {
    List<double> glucoseValues = map((e) => double.parse(e.value)).toList();
    glucoseValues.sort((a, b) => a.compareTo(b));
    return glucoseValues.isNotEmpty ?glucoseValues.first:0.0;
  }

  double maximumGlucoseValue() {
    List<double> glucoseValues = map((e) => double.parse(e.value)).toList();
    glucoseValues.sort((a, b) => a.compareTo(b));
    return glucoseValues.isNotEmpty ?glucoseValues.last:0.0;
  }

  double averageGlucoseValue() {
    List<double> glucoseValues = map((e) => double.parse(e.value)).toList();
    double sum = glucoseValues.fold(0, (previousValue, element) => previousValue + element);
    return sum / length;
  }

  double medianGlucoseValue() {
    var middle = length ~/ 2;
    if (length % 2 == 1) {
      return double.parse(this[middle].value);
    } else {
      return isNotEmpty?(double.parse(this[middle - 1].value) + double.parse(this[middle].value)) / 2.0:0.0;
    }
  }
}

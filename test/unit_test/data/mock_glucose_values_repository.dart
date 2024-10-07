
import 'package:glucose_plot_application/data/glucose_values_repository.dart';
import 'package:glucose_plot_application/domain/glucose_sample_model.dart';
import 'package:mocktail/mocktail.dart';

class MockGlucoseValuesRepository extends Mock implements GlucoseValuesRepository {
  @override
  Future<List<GlucoseSample>> fetchGlucoseValues() async {
    return Future.delayed(const Duration()).then(
          (value) {
            List<GlucoseSample> s= List<GlucoseSample>.from((data["bloodGlucoseSamples"]!.map((x) => GlucoseSample.fromJson(x))));
            return s;
          },
    );
  }
}

class MockErrorGlucoseValuesRepository extends Mock implements GlucoseValuesRepository {
  @override
  Future<List<GlucoseSample>> fetchGlucoseValues() async {
      throw "Error Happened";
  }
}

var data = {
  "bloodGlucoseSamples": [
    {"value": "7.7", "timestamp": "2021-02-10T09:08:00", "unit": "mmol/L"},
    {"value": "7.7", "timestamp": "2021-02-10T09:25:00", "unit": "mg/dl"},
    {"value": "7.7", "timestamp": "2021-02-10T09:40:00", "unit": "mmol/L"},
    {"value": "7.8", "timestamp": "2021-02-10T10:10:00", "unit": "mmol/L"},
    {"value": "8.3", "timestamp": "2021-02-10T10:25:00", "unit": "mmol/L"},
  ]
};

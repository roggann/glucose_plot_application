import 'package:glucose_plot_application/api/api_client.dart';
import 'package:glucose_plot_application/api/api_result.dart';
import 'package:glucose_plot_application/domain/glucose_sample_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GlucoseValuesRepository {
  final ApiClient apiClient;

  const GlucoseValuesRepository({required this.apiClient});

  Future<List<GlucoseSample>> fetchGlucoseValues() async {
    ApiResult result = await apiClient.get(url: "sample.json");
    if (result.type == ApiResultType.success) {
      return List<GlucoseSample>.from(result.data["bloodGlucoseSamples"].map((x) => GlucoseSample.fromJson(x)));
    } else {
      throw result.errorMessage;
    }
  }

}

final getGlucoseValuesProvider = Provider<GlucoseValuesRepository>(
      (ref) => GlucoseValuesRepository(
    apiClient: ref.watch(dioProvider),
  ),
);

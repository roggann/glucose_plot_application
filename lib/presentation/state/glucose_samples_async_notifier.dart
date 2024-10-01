
import 'package:equatable/equatable.dart';
import 'package:glucose_plot_application/data/glucose_values_repository.dart';
import 'package:glucose_plot_application/domain/glucose_sample_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:async';

class GlucoseSamplesAsyncNotifier extends FamilyAsyncNotifier<List<GlucoseSample>?, DateFilterOptions> {
  @override
  FutureOr<List<GlucoseSample>?> build(arg) {
    return fetchGlucoseData(arg);
  }

  Future<List<GlucoseSample>?> fetchGlucoseData(DateFilterOptions dateFilterOptions) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
          () => ref.watch(getGlucoseValuesProvider).fetchGlucoseValues(),
    );
    return state.value;
  }
}

class DateFilterOptions extends Equatable{
  final DateTime startDateTime;
  final DateTime endDatetime;

  const DateFilterOptions({
    required this.endDatetime,
    required this.startDateTime,
});

  @override
  List<Object?> get props => [startDateTime,endDatetime];
}

final glucoseSamplesAsyncNotifier= AsyncNotifierProviderFamily<GlucoseSamplesAsyncNotifier, List<GlucoseSample>?, DateFilterOptions>(() {
  return GlucoseSamplesAsyncNotifier();
});
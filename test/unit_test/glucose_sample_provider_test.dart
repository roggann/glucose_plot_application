import 'package:flutter_test/flutter_test.dart';
import 'package:glucose_plot_application/data/glucose_values_repository.dart';
import 'package:glucose_plot_application/domain/glucose_sample_model.dart';
import 'package:glucose_plot_application/presentation/state/glucose_samples_async_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';

import 'data/mock_glucose_values_repository.dart';


class Listener<T> extends Mock {
  void call(T? previous, T next);
}
void main() {
  setUpAll(() {
    registerFallbackValue(const AsyncLoading<void>());
  });

  test('fetch Glucose samples test', () async {
    List<GlucoseSample> glucoseSamples = [
      GlucoseSample(value: "7.7", unit: "mmol/L", timestamp: DateTime(2021,2,10,9,8,0)),
      GlucoseSample(value: "7.7", unit: "mg/dl", timestamp: DateTime(2021,2,10,9,25,0)),
      GlucoseSample(value: "7.7", unit: "mmol/L", timestamp: DateTime(2021,2,10,9,40,0)),
      GlucoseSample(value: "7.8", unit: "mmol/L", timestamp: DateTime(2021,2,10,10,10,0)),
      GlucoseSample(value: "8.3", unit: "mmol/L", timestamp: DateTime(2021,2,10,10,25,0)),

    ];
    final mockGlucoseValuesRepository = MockGlucoseValuesRepository();
    final listener = Listener();
    final container = ProviderContainer(
      overrides: [
        getGlucoseValuesProvider.overrideWithValue(mockGlucoseValuesRepository),
      ],
    );
    addTearDown(container.dispose);
    container.listen(
      glucoseSamplesAsyncNotifier(DateFilterOptions(endDatetime: DateTime(2021,2,10,10,25,0),startDateTime:DateTime(2021,2,10,9,8,0))),
      listener,
      fireImmediately: true,
    );

    /// fetch initial data
    verify(() => listener(null, const AsyncLoading<List<GlucoseSample>?>()));
    verifyNoMoreInteractions(listener);
    await container.read(glucoseSamplesAsyncNotifier(DateFilterOptions(endDatetime: DateTime(2021,2,10,10,25,0),startDateTime:DateTime(2021,2,10,9,8,0))).future);
    verify(() => listener(const AsyncLoading<List<GlucoseSample>?>(), any(that: isA<AsyncData<List<GlucoseSample>?>>())));
    expect(container.read(glucoseSamplesAsyncNotifier(DateFilterOptions(endDatetime: DateTime(2021,2,10,10,25,0),startDateTime:DateTime(2021,2,10,9,8,0)))).value, glucoseSamples);
  });


  test('error fetch Glucose samples test', () async {

    final mockErrorGlucoseValuesRepository = MockErrorGlucoseValuesRepository();

    final listener = Listener();
    final container = ProviderContainer(
      overrides: [
        getGlucoseValuesProvider.overrideWithValue(mockErrorGlucoseValuesRepository),
      ],
    );

    addTearDown(container.dispose);
    container.listen(
      glucoseSamplesAsyncNotifier(DateFilterOptions(endDatetime: DateTime(2021,2,10,10,25,0),startDateTime:DateTime(2021,2,10,9,8,0))),
      listener,
      fireImmediately: true,
    );


    await container.read(glucoseSamplesAsyncNotifier(DateFilterOptions(endDatetime: DateTime(2021,2,10,10,25,0),startDateTime:DateTime(2021,2,10,9,8,0))).future);
    verifyInOrder([
          () => listener(any(that: isA<AsyncData<List<GlucoseSample>?>>()), any(that: isA<AsyncLoading<List<GlucoseSample>?>>())),
          () => listener(any(that: isA<AsyncLoading>()), any(that: isA<AsyncError<List<GlucoseSample>?>>())),
    ]);

  });



}
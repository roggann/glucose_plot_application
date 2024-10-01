import 'package:flutter/material.dart';
import 'package:glucose_plot_application/domain/glucose_sample_model.dart';
import 'package:glucose_plot_application/presentation/state/glucose_samples_async_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ref
                .watch(glucoseSamplesAsyncNotifier(
                    DateFilterOptions(endDatetime: DateTime(2021, 2, 10), startDateTime: DateTime(2021,2,10))))
                .when(
              data: (samples) {
                return SfCartesianChart(primaryXAxis: const DateTimeAxis(), series: <CartesianSeries>[
                  // Renders line chart
                  LineSeries<GlucoseSample, DateTime>(
                    dataSource: samples,
                    xValueMapper: (GlucoseSample sample, _) => sample.timestamp,
                    yValueMapper: (GlucoseSample sample, _) => num.parse(sample.value),
                  )
                ]);
              },
              error: (error, _) {
                return Column(
                  children: [
                    Center(
                      child: ElevatedButton(
                        child: Text("Retry"),
                        onPressed: () => ref.invalidate(glucoseSamplesAsyncNotifier),
                      ),
                    ),
                  ],
                );
              },
              loading: () {
                return Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height - 326,
                  color: Colors.transparent,
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

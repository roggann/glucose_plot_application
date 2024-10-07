import 'package:flutter/material.dart';
import 'package:glucose_plot_application/domain/glucose_sample_model.dart';
import 'package:glucose_plot_application/helpers/show_date_time_picker.dart';
import 'package:glucose_plot_application/presentation/state/glucose_samples_async_notifier.dart';
import 'package:glucose_plot_application/presentation/state/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
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
            ref.watch(glucoseSamplesAsyncNotifier(DateFilterOptions(endDatetime: ref.watch(endDateProvider), startDateTime: ref.watch(startDateProvider)))).when(
              data: (samples) {
                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 16,
                        ),
                        Text("Start:${DateFormat('dd/MM/yyyy hh:mm a').format(ref.watch(startDateProvider))}",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500,)),
                        const SizedBox(
                          width: 16,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              DateTime? startDateTime = await showDateTimePicker(context);
                              if (startDateTime != null) {
                                ref.watch(startDateProvider.notifier).state = startDateTime;
                              }
                            },
                            child: const Text("Change Start Date"))
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 16,
                        ),
                        Text("End:${DateFormat('dd/MM/yyyy hh:mm a').format(ref.watch(endDateProvider))}",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500,)),
                        const SizedBox(
                          width: 16,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              DateTime? endDateTime = await showDateTimePicker(context);
                              if (endDateTime != null) {
                                ref.watch(endDateProvider.notifier).state = endDateTime;
                              }
                            },
                            child: const Text("Change end Date"))
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SfCartesianChart(primaryXAxis: const DateTimeAxis(), series: <CartesianSeries>[
                      // Renders line chart
                      LineSeries<GlucoseSample, DateTime>(
                        dataSource: samples,
                        xValueMapper: (GlucoseSample sample, _) => sample.timestamp,
                        yValueMapper: (GlucoseSample sample, _) => num.parse(sample.value),
                      )
                    ],
                    tooltipBehavior: TooltipBehavior(enable: true),),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 16,
                        ),
                        Text("Minimum: ${samples?.minimumGlucoseValue()}",style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500,),),
                        const SizedBox(
                          width: 16,
                        ),
                        Text("Maximum: ${samples?.maximumGlucoseValue()}",style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500,)),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 16,
                        ),
                        Text("Average:${samples?.averageGlucoseValue().toStringAsFixed(4)}",style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500,)),
                        const SizedBox(
                          width: 16,
                        ),
                        Text("Median:${samples?.medianGlucoseValue()}",style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500,)),
                      ],
                    ),

                  ],
                );
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
                  height: 200,
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

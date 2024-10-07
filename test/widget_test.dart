import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glucose_plot_application/data/glucose_values_repository.dart';

import 'package:glucose_plot_application/presentation/my_home_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'unit_test/data/mock_glucose_values_repository.dart';

void main() {
  testWidgets('Home page test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(ProviderScope(
        overrides: [getGlucoseValuesProvider.overrideWithValue(MockGlucoseValuesRepository())],
        child: const MediaQuery(
          data: MediaQueryData(),
          child: MaterialApp(
            home: MyHomePage(
              title: "test plot",
            ),
          ),
        )));
    await tester.pumpAndSettle();
    expect(find.text("test plot"), findsOneWidget);
    expect(find.textContaining("Minimum"), findsOneWidget);
    expect(find.byType(SfCartesianChart), findsOneWidget);
  });
}

import 'package:hooks_riverpod/hooks_riverpod.dart';

final startDateProvider = StateProvider<DateTime>((ref) => DateTime(2021, 2, 10));
final endDateProvider = StateProvider<DateTime>((ref) => DateTime(2021,2,11));
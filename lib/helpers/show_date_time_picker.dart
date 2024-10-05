import 'package:flutter/material.dart';

Future<DateTime?> showDateTimePicker(BuildContext context) async {
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime(2022, 1),
    initialEntryMode: DatePickerEntryMode.calendarOnly,
    firstDate: DateTime(2021, 2),
    lastDate: DateTime(2022, 1),
    locale: Locale(Localizations.localeOf(context).languageCode),
    builder: (context, child) {
      return Theme(
        data: ThemeData(
          colorScheme: ColorScheme.light(
            primary: Theme.of(context).colorScheme.primary,
            onPrimary: Theme.of(context).colorScheme.onPrimary,
            onSurface: Theme.of(context).colorScheme.onSurface,
            background: Theme.of(context).colorScheme.background,
            onBackground: Theme.of(context).colorScheme.onBackground,
            secondaryContainer: Theme.of(context).colorScheme.secondaryContainer,
            secondary: Theme.of(context).colorScheme.primary,
            onSecondary: Theme.of(context).colorScheme.onSecondary,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.primary, // button text color
            ),
          ),
        ),
        child: child!,
      );
    },
    useRootNavigator: false,
  ).then((date) async {
    if (date == null) {
      return null;
    } else {
      final TimeOfDay? timePicked = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          initialEntryMode: TimePickerEntryMode.dial,
          builder: (context, child) {
            return Theme(
              data: ThemeData(
                colorScheme: ColorScheme.light(
                  primary: Theme.of(context).colorScheme.primary,
                  onPrimary: Theme.of(context).colorScheme.onPrimary,
                  onSurface: Theme.of(context).colorScheme.onSurface,
                  background: Theme.of(context).colorScheme.background,
                  onBackground: Theme.of(context).colorScheme.onBackground,
                  secondaryContainer: Theme.of(context).colorScheme.secondaryContainer,
                  secondary: Theme.of(context).colorScheme.primary,
                  onSecondary: Theme.of(context).colorScheme.onSecondary,
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.primary, // button text color
                  ),
                ),
              ),
              child: child!,
            );
          },
          useRootNavigator: false);

      if (timePicked == null) {
        return null;
      } else {
        DateTime newDateTime = DateTime(date.year, date.month, date.day, timePicked.hour, timePicked.minute);
        return newDateTime;
      }
    }
  });
  return pickedDate;
}

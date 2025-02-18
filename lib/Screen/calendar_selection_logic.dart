import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void handleDaySelection(DateTime selectedDay, DateTime startDate,
    DateTime endDate, Function(DateTime, DateTime) onSelectionChanged) {
  if (startDate.isAfter(selectedDay) || endDate.isBefore(selectedDay)) {
    onSelectionChanged(selectedDay, selectedDay);
  } else {
    if (startDate.isAfter(selectedDay) || endDate.isBefore(selectedDay)) {
      onSelectionChanged(selectedDay, selectedDay);
    } else {
      onSelectionChanged(DateTime.now().toLocal(), DateTime.now().toLocal());
    }
  }
}

bool isSameDay(DateTime day1, DateTime day2) {
  return day1.year == day2.year &&
      day1.month == day2.month &&
      day1.day == day2.day;
}

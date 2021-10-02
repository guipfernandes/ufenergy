import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

String formatDateTimeToString(DateTime date) {
  initializeDateFormatting();
  final df = DateFormat("d 'de' MMMM 'de' yyyy 'às' HH'h'mm'min'", 'pt');
  return df.format(date);
}

String formatDateTime(DateTime date, String format) {
  initializeDateFormatting();
  final df = DateFormat(format, 'pt');
  return df.format(date);
}

DateTime parseDateTime(String date, String format) {
  initializeDateFormatting();
  final df = DateFormat(format, 'pt');
  return df.parse(date);
}

DateTime dateTimeCombine(DateTime date, TimeOfDay? time) =>
    DateTime(date.year, date.month, date.day, time?.hour ?? 0, time?.minute ?? 0);
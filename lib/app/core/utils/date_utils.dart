import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

String formatDateTimeToString(DateTime date) {
  initializeDateFormatting();
  final df = DateFormat("d 'de' MMMM 'de' yyyy 'às' HH'h'mm'min'", 'pt');
  return df.format(date);
}
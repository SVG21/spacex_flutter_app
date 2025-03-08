import 'package:intl/intl.dart';

String formatDateTime(DateTime dateTime) {
  String formattedDate = DateFormat('MMMM d, y').format(dateTime);
  String formattedTime = DateFormat('hh:mm a').format(dateTime.toUtc()); // 10:30 PM UTC
  return '$formattedDate at $formattedTime UTC';
}

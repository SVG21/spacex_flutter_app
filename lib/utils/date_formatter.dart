import 'package:intl/intl.dart';

//  Converts `DateTime` to a user-friendly format
String formatDateTime(DateTime dateTime) {
  String formattedDate = DateFormat('MMMM d, y').format(dateTime);
  String formattedTime =
      DateFormat('hh:mm a').format(dateTime.toUtc());
  return '$formattedDate at $formattedTime UTC';
}

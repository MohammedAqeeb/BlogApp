import 'package:intl/intl.dart';

String dateFormatter(DateTime dateTime) {
  return DateFormat('dd MMM, yyyy').format(dateTime);
}

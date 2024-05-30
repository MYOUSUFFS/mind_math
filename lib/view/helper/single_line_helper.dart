import 'package:intl/intl.dart';

String dateFormatWithTime(DateTime date) =>
    DateFormat('dd MMM yyyy HH:mm').format(date); // Format Like "10 Mar 2024 10:10"

String dateFormat(DateTime date) =>
    DateFormat('dd MMM yyyy').format(date); // Format Like "10 Mar 2024"

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

String formatDate(BuildContext context, String? date,
    {String format = "dd MMM yyyy"}) {
  initializeDateFormatting();

  try {
    var dateFormat = DateFormat(format); // you can change the format here
    var utcDate =
        dateFormat.format(DateTime.parse(date!)); // pass the UTC time here
    var localDate = dateFormat.parse(utcDate, true).toLocal();
    // String createdDate = dateFormat.format(DateTime.parse(localDate));
    // var dt = DateTime.parse(date!).toLocal();
    // DateFormat(format, "id").format(DateTime.parse(date!));
    return DateFormat(format, "id").format(localDate);
  } catch (e) {
    print(e);
  }

  return "-";
}

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

String formatDate(BuildContext context, String? date,
    {String format = "dd MMM yyyy"}) {
  initializeDateFormatting();

  try {
    return DateFormat(format, "id").format(DateTime.parse(date!));
  } catch (e) {
    print(e);
  }

  return "-";
}

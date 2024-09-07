import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String getFormattedDate(DateTime dt, {String pattern = "dd/MM/yyyy"}) {
  return DateFormat(pattern).format(dt);
}

String getFormattedTime(TimeOfDay tm, {String pattern = 'HH:mm'}) {
  return DateFormat(pattern).format(DateTime(0, 0, 0, tm.hour, tm.minute));
}

void showMsg(BuildContext context, String message) =>
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));

int getGrandTotal(int totalSeatBooked, int price) {
  final subTotal = totalSeatBooked * price;
  return (subTotal + 150).toInt();
}

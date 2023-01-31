import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

void playWithExtension() {
  final birthdate = "30/06/1995".toDate().millisecondsSinceEpoch;
  final today = DateTime.now().millisecondsSinceEpoch;

  final daysDiff = Duration(milliseconds: today - birthdate).inDays;
  final yearsOld = daysDiff / 365;
  if (kDebugMode) {
    print("Years old: ${yearsOld.toInt()}");
  }
}

extension DateOnStringExtension on String {
  DateTime toDate() {
    final dateFormat = DateFormat("dd/MM/yyyy");
    return dateFormat.parse(this);
  }
}

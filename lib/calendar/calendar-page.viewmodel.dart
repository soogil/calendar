import 'package:flutter/material.dart';

const DAY_OF_WEEKS = ['일', '월', '화', '수', '목', '금', '토'];

class CalendarPageViewModel {
  CalendarPageViewModel() : dateTime = DateTime.now();

  final DateTime dateTime;

  Color getColor(int weekDay) {
    if(weekDay == 0) return Colors.red;
    else if(weekDay == 6) return Colors.blue;
    else return Colors.white;
  }

  DateTime getDateTime({int year = 0, int month = 0}) =>
      DateTime(dateTime.year + year, dateTime.month + month, 1);
}
import 'package:flutter/material.dart';

const DAY_OF_WEEKS = ['일', '월', '화', '수', '목', '금', '토'];

class CalendarPageViewModel {
  Color getColor(int weekDay) {
    if(weekDay == 0) return Colors.red;
    else if(weekDay == 6) return Colors.blue;
    else return Colors.white;
  }
}
import 'package:flutter/material.dart';
import 'package:calendar/calendar/content/calendar-day.viewmodel.dart';


class CalendarDayView extends StatelessWidget {
  CalendarDayView(DateTime dateTime) : viewModel = CalendarDayViewModel(dateTime);

  final CalendarDayViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return _buildUI();
  }

  Widget _buildUI() {
    final indexedFirstWeekDay = viewModel.indexedFirstWeekDay;
    final lastDayOfMonth = viewModel.currentLastDayOfMonth;
    int prevDayOfMonth = viewModel.prevLastDayOfMonth - indexedFirstWeekDay + 1;
    int nextDayOfMonth = viewModel.nextMonthFirstDay;

    return Container(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: viewModel.daysPerWeek,
        ),
        itemBuilder: (context, index) {
          final int day = index - indexedFirstWeekDay + 1;

          if (indexedFirstWeekDay > index) {
            return _getDayItem(prevDayOfMonth++, color: Colors.grey);
          } else if (index > lastDayOfMonth + indexedFirstWeekDay - 1) {
            return _getDayItem(nextDayOfMonth++, color: Colors.grey);
          }

          final weekDay = viewModel.weekDay(day: day);
          final Color textColor = weekDay == DateTime.sunday
              ? Colors.red : weekDay == DateTime.saturday
              ? Colors.blue : Colors.black;

          return _getDayItem(
              day,
              borderColor: day == viewModel.currentDay ? Colors.yellow : Colors.transparent,
              textColor: textColor
          );
        },
        itemCount: TOTAL_CALENDAR_DAY_COUNT,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }

  _getDayItem(int day, {
    Color color = Colors.transparent,
    Color borderColor = Colors.transparent,
    Color textColor = Colors.black,
  }) {
    return Container(
      decoration: BoxDecoration(
          color: color,
          border: Border.all(color: borderColor, width: 3)
      ),
      alignment: Alignment.topCenter,
      child: Text(
        '$day',
        style: TextStyle(
            color: textColor,
            fontSize: 15
        ),
      ),
    );
  }
}

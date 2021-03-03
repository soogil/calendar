import 'package:calendar/calendar/day/calendar-day.viewmodel.dart';
import 'package:flutter/material.dart';


class CalendarDayView extends StatelessWidget {
  CalendarDayView(DateTime dateTime) : viewModel = CalendarDayViewModel(dateTime);

  final CalendarDayViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return _buildUI();
  }

  Widget _buildUI() {
    final weekDay = viewModel.itemIndexWeekDay;
    final lastDayOfMonth = viewModel.currentLastDayOfMonth;
    int prevDayOfMonth = viewModel.prevLastDayOfMonth - weekDay + 1;
    int nextDayOfMonth = viewModel.nextMonthFirstDay;

    return Container(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: viewModel.daysPerWeek,
        ),
        itemBuilder: (context, index) {
          final day = index - weekDay + 1;

          if(weekDay > index) {
            return _getDayItem(prevDayOfMonth++, color: Colors.grey);
          } else if(index > lastDayOfMonth + weekDay - 1) {
            return _getDayItem(nextDayOfMonth++, color: Colors.grey);
          }

          return _getDayItem(day, borderColor: day == viewModel.currentDay ? Colors.yellow : Colors.transparent);
        },
        itemCount: TOTAL_CALENDAR_DAY_COUNT,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }

  _getDayItem(int day, {Color color = Colors.transparent, Color borderColor = Colors.transparent}) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: borderColor, width: 3)
      ),
      alignment: Alignment.topCenter,
      child: Text('$day'),
    );
  }
}

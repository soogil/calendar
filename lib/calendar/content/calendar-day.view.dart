import 'package:calendar/cubit/selected-day-cubit.dart';
import 'package:flutter/material.dart';
import 'package:calendar/calendar/content/calendar-day.viewmodel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef OnChangeSelectedMonth(CalendarMonth calendarMonth);

class CalendarDayView extends StatelessWidget {
  CalendarDayView({DateTime dateTime, this.onChangeSelectedMonth}) : viewModel = CalendarDayViewModel(dateTime);

  final CalendarDayViewModel viewModel;
  final OnChangeSelectedMonth onChangeSelectedMonth;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SelectedDayCubit>(
      create: (context) => SelectedDayCubit(viewModel.currentDate),
        child: _buildUI()
    );
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
            return _getDayItem(prevDayOfMonth++, opacity: 0.5, calendarMonth: CalendarMonth.PREV);
          } else if (index > lastDayOfMonth + indexedFirstWeekDay - 1) {
            return _getDayItem(nextDayOfMonth++, opacity: 0.5, calendarMonth: CalendarMonth.NEXT);
          }

          final weekDay = viewModel.weekDay(day: day);
          final Color textColor = weekDay == DateTime.sunday
              ? Colors.red : weekDay == DateTime.saturday
              ? Colors.blue : Colors.white;

          return _getDayItem(
            day,
            textColor: textColor,
            calendarMonth: CalendarMonth.CURRENT,
          );
        },
        itemCount: TOTAL_CALENDAR_DAY_COUNT,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }

  _getDayItem(int day, {
    Color textColor = Colors.white,
    double opacity = 1,
    CalendarMonth calendarMonth = CalendarMonth.CURRENT,
  }) {
    return BlocBuilder<SelectedDayCubit, DateTime>(
      builder: (context, dateTime) {
        final isCurrentMonth = calendarMonth == CalendarMonth.CURRENT;
        final borderColor = viewModel.currentDate.day == day && isCurrentMonth ? Colors.yellow : Colors.transparent;

        return GestureDetector(
          onTap: () => isCurrentMonth ? context.read<SelectedDayCubit>().dateTime = viewModel.selectedDate(day)
              : onChangeSelectedMonth(calendarMonth),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: borderColor, width: 3)
            ),
            alignment: Alignment.topCenter,
            child: Text(
              '$day',
              style: TextStyle(
                color: textColor.withOpacity(opacity),
                fontSize: 17,
              ),
            ),
          ),
        );
      },
    );
  }
}

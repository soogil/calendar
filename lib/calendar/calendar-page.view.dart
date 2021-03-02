import 'package:calendar/calendar/calendar-page.viewmodel.dart';
import 'package:calendar/cubit/datetime-cubit.dart';
import 'package:calendar/service/resolution.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CalendarPageView extends StatelessWidget {

  CalendarPageViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    _viewModel ??= CalendarPageViewModel(context.read<DateTimeCubit>().value);
    ResolutionService().init(context);

    return SafeArea(
      child: Scaffold(
        body: _getBody(),
      ),
    );
  }

  Widget _getBody() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getYearAndMonth(),
          _getDayOfWeek(),
          _getDays(),
        ],
      ),
    );
  }

  Widget _getYearAndMonth() {
    return FlatButton(
      onPressed: () {},
      child: BlocBuilder<DateTimeCubit, DateTime>(
        builder: (context, dateTime) {
          return Container(
            child: Text(
              '${dateTime.month}월 ${dateTime.year}년'
            ),
          );
        },
      ),
    );
  }

  Widget _getDayOfWeek() {
    List<Widget> items = List.generate(
        DAY_OF_WEEKS.length, (index) => Container(
          child: Center(
            child: Text(
              DAY_OF_WEEKS[index],
              style: TextStyle(
                fontSize: ResolutionService().getSp(25),
                // color: _viewModel.getColor(index),
              ),
            ),
          ),
        ));

    return Container(
      color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: items
      ),
    );
  }

  Widget _getDays() {
    final weekDay = _viewModel.itemIndexWeekDay;
    final lastDayOfMonth = _viewModel.currentLastDayOfMonth;
    int prevDayOfMonth = _viewModel.prevLastDayOfMonth - weekDay + 1;
    int nextDayOfMonth = _viewModel.nextMonthFirstDay;

    return Container(
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _viewModel.daysPerWeek,
          ),
          itemBuilder: (context, index) {
            if(weekDay > index) return _getDayItem(prevDayOfMonth++, color: Colors.grey);
            else if(index > lastDayOfMonth) return _getDayItem(nextDayOfMonth++, color: Colors.grey);
            return _getDayItem(index - weekDay + 1);
          },
        itemCount: TOTAL_CALENDAR_DAY_COUNT,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }

  _getDayItem(int day, {Color color = Colors.transparent}) {
    return Container(
      alignment: Alignment.topCenter,
      color: color,
      child: Text(
        '$day'
      ),
    );
  }
}

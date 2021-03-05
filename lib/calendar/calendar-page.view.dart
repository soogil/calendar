import 'package:calendar/calendar/calendar-page.viewmodel.dart';
import 'package:calendar/calendar/content/calendar-day.view.dart';
import 'package:calendar/calendar/content/calendar-day.viewmodel.dart';
import 'package:calendar/cubit/datetime-cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CalendarPageView extends StatelessWidget {
  CalendarPageView(): viewModel = CalendarPageViewModel();

  final CalendarPageViewModel viewModel;
  final int initialPage = 999;

  PageController _pageController;

  @override
  Widget build(BuildContext context) {
    _pageController = PageController(initialPage: initialPage);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: _getBody(context),
      ),
    );
  }

  Widget _getBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white38,
                borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getYearAndMonth(),
                _getDayOfWeek(),
                _getDays(context),
              ],
            ),
          ),
        ),
        Expanded(
            flex: 1,
            child: Container()
        ),
      ],
    );
  }

  Widget _getYearAndMonth() {
    return FlatButton(
      onPressed: () {},
      child: BlocBuilder<DateTimeCubit, DateTime>(
        builder: (context, dateTime) {
          return Container(
            child: Text(
              '${dateTime.month}월 ${dateTime.year}년',
              style: TextStyle(
                color: Colors.white,
                fontSize: 23
              ),
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
                fontSize: 17,
                color: viewModel.getColor(index),
              ),
            ),
          ),
        ));

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: items
      ),
    );
  }

  Widget _getDays(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        controller: _pageController,
        itemBuilder: (context, index) {
          final int value = index - initialPage;
          final dateTime = viewModel.getDateTime(month: value);

          return CalendarDayView(
            dateTime: dateTime,
            onChangeSelectedMonth: (calendarMonth) {
              print(calendarMonth);
              if(calendarMonth == CalendarMonth.NEXT) {
                _pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
              } else {
                _pageController.previousPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
              }
            },
          );
        },
        onPageChanged: (page) {
          final int value = page - initialPage;
          final dateTime = viewModel.getDateTime(month: value);

          context.read<DateTimeCubit>().dateTime = dateTime;
        },
      ),
    );
  }
}

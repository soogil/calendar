import 'package:calendar/calendar/calendar-page.viewmodel.dart';
import 'package:calendar/calendar/day/calendar-day.view.dart';
import 'package:calendar/cubit/datetime-cubit.dart';
import 'package:calendar/service/resolution.service.dart';
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
    ResolutionService().init(context);

    return SafeArea(
      child: Scaffold(
        body: _getBody(context),
      ),
    );
  }

  Widget _getBody(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getYearAndMonth(),
          _getDayOfWeek(),
          _getDays(context),
          Expanded(child: Container())
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

  Widget _getDays(BuildContext context) {
    return Expanded(
      flex: 2,
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        controller: _pageController,
        itemBuilder: (context, index) {
          final int value = index - initialPage;
          final dateTime = viewModel.getDateTime(month: value);

          return CalendarDayView(dateTime);
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

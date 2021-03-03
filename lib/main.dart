import 'package:calendar/calendar/calendar-page.view.dart';
import 'package:calendar/cubit/datetime-cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  runApp(CalendarApp());
}

class CalendarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => DateTimeCubit())
        ],
        child: CalendarPageView(),
      )
    );
  }
}



const TOTAL_CALENDAR_DAY_COUNT = 42;

class CalendarDayViewModel {
  CalendarDayViewModel(DateTime dateTime) {
    _currentDateTime = dateTime;
    _prevDateTime = DateTime(dateTime.year, dateTime.month - 1, 1);
    _nextDateTime = DateTime(dateTime.year, dateTime.month + 1, 1);
  }

  DateTime _prevDateTime;
  DateTime _currentDateTime;
  DateTime _nextDateTime;

  int _getWeekDay(DateTime dateTime) => DateTime(dateTime.year, dateTime.month, 1).weekday;
  int _lastDayOfMonth(DateTime dateTime) => DateTime(dateTime.year, dateTime.month + 1, 0).day;

  int get currentDay => _currentDateTime.day;

  int get daysPerWeek => DateTime.daysPerWeek;

  int get itemIndexWeekDay => weekDay == 7 ? 0 : weekDay;

  int get weekDay => _getWeekDay(_currentDateTime);

  int get nextMonthFirstDay => _nextDateTime.day;

  int get prevLastDayOfMonth => _lastDayOfMonth(_prevDateTime);

  int get currentLastDayOfMonth => _lastDayOfMonth(_currentDateTime);
}
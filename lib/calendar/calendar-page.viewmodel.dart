
const DAY_OF_WEEKS = ['일', '월', '화', '수', '목', '금', '토'];

class CalendarPageViewModel {
  CalendarPageViewModel() : dateTime = DateTime.now();

  final DateTime dateTime;

  DateTime getDateTime({int year = 0, int month = 0}) =>
      DateTime(dateTime.year + year, dateTime.month + month, 1);
}
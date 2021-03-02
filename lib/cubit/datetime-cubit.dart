import 'package:calendar/cubit/base-cubit.dart';


class DateTimeCubit extends BaseCubit<DateTime> {
  DateTimeCubit({DateTime dateTime}) : super(dateTime ??= DateTime.now());

  int get year => value.year;

  set year(int year) => value = DateTime(year, value.month, value.day);

  int get month => value.month;

  set month(int month) => value = DateTime(value.year, month, value.day);

  int get day => value.day;

  set day(int day) => value = DateTime(value.year, value.month, day);
}

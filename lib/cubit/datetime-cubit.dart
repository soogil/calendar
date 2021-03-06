import 'package:calendar/cubit/base-cubit.dart';


class DateTimeCubit extends BaseCubit<DateTime> {
  DateTimeCubit({DateTime dateTime})
      : initDateTime = DateTime.now() , super(dateTime ?? DateTime.now());

  final DateTime initDateTime;

  DateTime get dateTime => this.value;

  set dateTime(DateTime value) => this.value = value;

  DateTime pickerChangeDateTime({int year = 0, int month = 0}) =>
      DateTime(this.value.year + year, this.value.month + month, 1);

  DateTime pageChangeDateTime({int year = 0, int month = 0}) =>
      DateTime(this.initDateTime.year + year, this.initDateTime.month + month, 1);
}

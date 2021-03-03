import 'package:calendar/cubit/base-cubit.dart';


class DateTimeCubit extends BaseCubit<DateTime> {
  DateTimeCubit({DateTime dateTime}) : super(dateTime ??= DateTime.now());

  set dateTime(DateTime value) => this.value = value;
}

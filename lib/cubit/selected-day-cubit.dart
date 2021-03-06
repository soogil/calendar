import 'package:calendar/cubit/base-cubit.dart';

class SelectedDayCubit extends BaseCubit<DateTime> {
  SelectedDayCubit(DateTime dateTime) : super(dateTime ??= DateTime.now());

  set dateTime(DateTime value) => this.value = value;
}

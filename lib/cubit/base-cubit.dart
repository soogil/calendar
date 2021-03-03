import 'package:flutter_bloc/flutter_bloc.dart';

class BaseCubit<T> extends Cubit<T> {
  BaseCubit(state) : super(state);

  T get value => this.state;
  set value(T state) => this.emit(state);
}
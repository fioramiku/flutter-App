import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';


class ThemeDartCubit extends Cubit<bool> {
  ThemeDartCubit() : super(false);

  bool check(bool b) {
    if (b == true) {
      return false;
    } else {
      return true;
    }
  }

  void themeEvent() {
    print(state.toString());
    emit(!state);
  }
}

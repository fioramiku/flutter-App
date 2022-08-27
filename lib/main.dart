import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'views/main_page/page_main.dart';

void main() {
  BlocOverrides.runZoned(() => runApp(const Basic_mainpage()));
}

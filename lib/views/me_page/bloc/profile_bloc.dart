import 'dart:developer';
import 'dart:ffi';
import 'dart:io';

import 'package:abc/database/Database_api.dart';
import 'package:abc/database/Transection_data.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(Initial_profile_state()) {
    on<Change_Profile>((event, emit) async {
      emit(state.copyWith(
          name: event.profile!.name,
          age: event.profile!.age,
          email: event.profile!.email,
          image: event.profile!.image));
      var db = Database_api();
      await db.dbAdd(event.profile!, 0);
      log("savedata");
    });

    on<Initial_Profile_Event>(((event, emit) async {
      var db = Database_api();
      var profileload = await db.dbload(0);
      if (profileload != null) {
        emit(state.copyWith(
            name: profileload.name,
            age: profileload.age,
            email: profileload.email,
            image: profileload.image));
      }
    }));

    log("loaddaata");
    on<ImageLoad>(
      (event, emit) async {
        await event.pickimag();
        emit(state.copyWith(image: event.file));
      },
    );
  }
}

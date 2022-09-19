part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class Change_Profile extends ProfileEvent {
  final ProfileState? profile;

  Change_Profile({this.profile});
}

class Initial_Profile_Event extends ProfileEvent {}

class ImageLoad extends ProfileEvent {
  File? file;

  Future pickimag() async {
    var file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null) return;
    final imgTemporary = File(file.path);
    this.file = imgTemporary;
    print(file.path.toString());
  }
}

part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final String? name;
  final String? email;
  final int? age;
  final File? image;

  const ProfileState({this.name, this.age, this.email,this.image});

  ProfileState copyWith({String? name, int? age, String? email,File? image}) {
    return ProfileState(
        name: name ?? this.name,
        age: age ?? this.age,
        email: email ?? this.email,
        image: image??this.image);
  }

  @override
  List<Object> get props => [
        {name, age, email,image}
      ];
}

class Initial_profile_state extends ProfileState {}

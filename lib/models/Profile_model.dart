import 'dart:io';

class Profile_model {
  final String? name;
  final String? email;
  final int? age;
  final File? image;

  const Profile_model({this.name, this.age, this.email,this.image});
}

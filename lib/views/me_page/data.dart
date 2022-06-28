import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'bloc/profile_bloc.dart';
import 'models/profile_models.dart';

class Niles {
  String name;
  String Pathimg;

  Niles(this.name, this.Pathimg);
}

class Setting_pagena extends StatelessWidget {
  final formkey = GlobalKey<FormState>();
  late var lastfile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Setting"),
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            final dynamic lastfile = state.image != null
                ? FileImage(state.image!)
                : AssetImage("assets/images/cover.png");
            return Form(
              key: formkey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        CircleAvatar(
                          backgroundImage: lastfile,
                          backgroundColor: Colors.yellowAccent,
                          radius: 50,
                        ),
                        TextButton(
                          child: Container(
                            child: Text("Change Image"),
                          ),
                          onPressed: () {
                            context.read<ProfileBloc>().add(ImageLoad());
                            context.read<ProfileBloc>().add(Change_Profile(
                                profile: ProfileState(image: state.image)));
                          },
                        ),
                        TextField(
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w200),
                          controller: TextEditingController(text: state.name),
                          onSubmitted: (String name) {
                            if (formkey.currentState!.validate()) {
                              context.read<ProfileBloc>().add(Change_Profile(
                                  profile: ProfileState(name: name)));
                            }
                            print("change");
                          },
                          decoration: InputDecoration(
                              labelText: "Name",
                              labelStyle:
                                  TextStyle(fontWeight: FontWeight.bold),
                              hintText: "What's your names?"),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          style: TextStyle(
                              fontWeight: FontWeight.w200, color: Colors.grey),
                          onSubmitted: (String email) {
                            if (formkey.currentState!.validate()) {
                              context.read<ProfileBloc>().add(Change_Profile(
                                  profile: ProfileState(email: email)));
                            }
                          },
                          controller: TextEditingController(text: state.email),
                          decoration: InputDecoration(
                              labelText: "Email",
                              labelStyle:
                                  TextStyle(fontWeight: FontWeight.bold),
                              hintText: "What's your email?"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}

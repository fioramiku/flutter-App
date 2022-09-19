import 'dart:math';
import 'package:abc/database/base_data_tool.dart';

import 'package:abc/views/me_page/bloc/profile_bloc.dart';
import 'package:abc/views/me_page/data.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class Me_page extends StatefulWidget {
  const Me_page({Key? key}) : super(key: key);

  @override
  State<Me_page> createState() => _Me_pageState();
}

class _Me_pageState extends State<Me_page> {
  List<Niles> names = [
    Niles("Account", "assets/images/cover.png"),
    Niles("Setting", "assets/images/cover.png"),
    Niles("Help Center", "assets/images/cover.png")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        dynamic fileimage =
            (state.image == null) ? NetworkImage("https://w7.pngwing.com/pngs/532/849/png-transparent-user-person-people-profile-account-human-avatar-administrator-worker-employee.png") : FileImage(state.image!);
        return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(height: 6,),
          Container(
            
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width,
            child: Column(children: [
              CircleAvatar(
                backgroundImage: fileimage,
                backgroundColor: Colors.yellowAccent,
                radius: 50,
              ),
              SizedBox(
                height: 6,
              ),
              Text('${state.name}',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                      color: Color.fromARGB(255, 255, 255, 255))),
             Expanded(
               child: Row(mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   Card(shape:  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)), child: Container(height: MediaQuery.of(context).size.width/3,width:  MediaQuery.of(context).size.width/3, decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.fill, image: NetworkImage("https://cdn.dribbble.com/users/2330950/screenshots/6128967/media/f2fabefb372f36800c4ed92464cd8ba3.jpg?compress=1&resize=400x300&vertical=top")))),),
                 ],
               ),
             )         
            ]),
          ),
         
        ]);
      },
    ));
  }
}

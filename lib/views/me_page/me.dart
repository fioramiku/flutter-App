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
        return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            decoration: BoxDecoration(
              color: maintheme().appBarTheme.backgroundColor,
            ),
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
            ]),
          ),
          Expanded(
              child: ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {},
                      child: Container(
                          height: 30,
                          child: Row(children: [
                            Image.asset(names[index].Pathimg),
                            Text(names[index].name)
                          ])),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(
                        height: 1,
                      ),
                  itemCount: names.length)),
        ]);
      },
    ));
  }
}

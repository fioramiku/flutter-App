import 'package:abc/database/base_data_tool.dart';
import 'package:abc/views/plan_main/clock.dart';
import 'package:abc/views/plan_main/widget/inputwork.dart';
import 'package:abc/views/plan_main/workroad.dart';
import 'package:flutter/material.dart';

class chat_page extends StatefulWidget {
  const chat_page({Key? key}) : super(key: key);

  @override
  State<chat_page> createState() => _chat_pageState();
}

class _chat_pageState extends State<chat_page> {
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  final formkey = GlobalKey<FormState>();
  TextEditingController constarttime = TextEditingController();
  TextEditingController conendtime = TextEditingController();
  TextEditingController contitle = TextEditingController();

  


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => showBottomSheet(
                context: context,
                builder: (_) {
                  return Inputwork();
                })),
        body: Column(
          children: [
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.zero, bottom: Radius.circular(8)),
                 color: allcolors[0]
                ),
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Clockplan(),
                )),
            Expanded(child: Workroad())
          ],
        ));
  }
}

import 'package:abc/views/todo_page/inputdoto.dart';
import 'package:abc/views/todo_page/todo_view.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _tabcontroller = TabController(length: 2, vsync: this);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            showBottomSheet(context: context, builder: (_) => InputTodowork()),
        child: Icon(Icons.add),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
             
              width: double.infinity,
              child: TabBar(
                labelColor: Theme.of(context).appBarTheme.backgroundColor,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Theme.of(context).appBarTheme.backgroundColor,
                  
                  controller: _tabcontroller,
                  tabs: <Tab>[
                    Tab(
                      text: 'Working',
                    ),
                    Tab(text: 'Work')
                  ]),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            width: double.maxFinite,
            height: 300,
            child: TabBarView(controller: _tabcontroller, children: <Widget>[
              TodoView(),
              Container(
                  child: Center(
                child: Text("text"),
              )),
            ]),
          ),
        ],
      ),
    );
  }
}

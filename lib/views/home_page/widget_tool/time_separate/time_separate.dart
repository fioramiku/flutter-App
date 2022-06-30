import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';

class Timeseparate_tool extends StatefulWidget {
  const Timeseparate_tool({Key? key}) : super(key: key);

  @override
  State<Timeseparate_tool> createState() => _Timeseparate_toolState();
}

class _Timeseparate_toolState extends State<Timeseparate_tool> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Stack(
            children: <Widget>[Container(width:MediaQuery.of(context).size.width
             ,             decoration: BoxDecoration( borderRadius: BorderRadius.all(Radius.circular(3))),
              child: Lottie.network("https://assets10.lottiefiles.com/packages/lf20_aorkkcxr.json"),
            ),]
          ),
        ],
      ),
    );
  }
}


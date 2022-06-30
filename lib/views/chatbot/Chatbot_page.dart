import 'dart:convert';
import 'dart:developer';

import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

class Chatbot extends StatefulWidget {
  const Chatbot({Key? key}) : super(key: key);

  @override
  State<Chatbot> createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  final GlobalKey<AnimatedListState> _listkey = GlobalKey();
  static Uri BOT_URL =
      Uri(scheme: 'https', host: 'mychatbotxux.herokuapp.com', path: '/bot');

  List<String> _data = [];
  TextEditingController _queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedList(
            key: _listkey,
            initialItemCount: _data.length,
            itemBuilder: ((context, index, animation) {
              return _buildItem(_data[index], animation, index);
            })),
        Align(
          alignment: Alignment.bottomCenter,
          child: TextField(
            decoration: InputDecoration(icon: Icon(Icons.message)),
            controller: _queryController,
            textInputAction: TextInputAction.send,
            onSubmitted: (msg) {
              this._getResponse();
            },
          ),
        )
      ],
    );
  }

  http.Client _getClient() {
    return http.Client();
  }

  void _getResponse() {
    if (_queryController.text.length > 0) {
      this._insertSingleItem(_queryController.text);
      var client = _getClient();
      try {
        client.post(
          BOT_URL,
          body: {"query": _queryController.text},
        )..then((response) {
            log(response.headers.toString());
            Map<String, dynamic> data = jsonDecode(response.body);
            _insertSingleItem(data['response'] + "<bot>");
          });
      } catch (e) {
        print("Failed -> $e");
      } finally {
        client.close();
        _queryController.clear();
      }
    }
  }

  void _insertSingleItem(String message) {
    _data.add(message);
    _listkey.currentState!.insertItem(_data.length - 1);
  }

  Widget _buildItem(String item, Animation<double> animation, int index) {
    bool mine = item.endsWith("<bot>");
    return SizeTransition(
        sizeFactor: animation,
        child: Padding(
          padding: EdgeInsets.only(top: 10),
          child: Container(
              alignment: mine ? Alignment.topLeft : Alignment.topRight,
              child: Bubble(
                child: Text(item.replaceAll("<bot>", "")),
                color: mine ? Colors.blue : Colors.indigo,
                padding: BubbleEdges.all(10),
              )),
        ));
  }
}

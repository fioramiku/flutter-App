import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Home_page extends StatefulWidget {
  const Home_page({Key? key}) : super(key: key);

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            child: Lottie.network(
                "https://assets2.lottiefiles.com/packages/lf20_4fewfamh.json"),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text("Reading"),
            style: ElevatedButton.styleFrom(shape: StadiumBorder()),
          )
        ],
      ),
    ));
  }
}

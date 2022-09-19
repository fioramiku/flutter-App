import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SliverWidget extends StatelessWidget {
  final String text;
  final String src;
  final bool centerTitle;

  const SliverWidget(
      {Key? key,
      required this.text,
      required this.src,
      required this.centerTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        title: Text(
          text,
          style: const TextStyle(
            
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        centerTitle: centerTitle,
      
        expandedHeight: 200.0,
      
        pinned: true,
        elevation: 10,
        flexibleSpace: FlexibleSpaceBar(background: ImageFiltered(imageFilter:ColorFilter.mode(
                            Colors.grey.withOpacity(0.3), BlendMode.dstATop) , child: Image.network( src,fit: BoxFit.cover,),)));
  }
}

import 'dart:developer';
import 'dart:math' as math;
import 'package:abc/views/plan_main/bloc/timemanage_bloc.dart';
import 'package:abc/views/plan_main/models/time_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../database/base_data_tool.dart';

class Clockplan extends StatefulWidget {
  const Clockplan({Key? key}) : super(key: key);

  @override
  State<Clockplan> createState() => _ClockplanState();
}

class _ClockplanState extends State<Clockplan> with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  final Tween<double> _rotationTween = Tween(begin: 0, end: (2) * math.pi);
  late DateTime _selectday;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(days: 1),
    );

    animation = _rotationTween.animate(controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          log("repeat");
          controller.repeat();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime nowtime = DateTime.now();
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width * 0.7,
        child: Stack(
          children: [
            BlocBuilder<TimemanageBloc, TimemanageState>(
                builder: (context, state) {
              if (state is BuildClockState) {
                _selectday = state.selectday;

                return Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: CustomPaint(
                    painter: Clock(
                        context: context,
                        models: state.mclock![_selectday] ?? [],
                        startpos: animation.value,
                        now: nowtime),
                    child: Container(),
                  ),
                );
              } else {
                return Text('null');
              }
            })
          ],
        ));
  }
}

class Clock extends CustomPainter {
  final startpos;
  final List<models_clock> models;
  final DateTime now;
  final BuildContext context;
  late int pointelement;
  void setter(int num) => this.pointelement = num;
  Clock(
      {required this.startpos,
      required this.models,
      required this.now,
      required this.context
      });

  double timenow() {
    double time = ((12 * 3600 -
                (now.hour.toDouble() * 60 * 60 +
                    now.minute * 60 +
                    now.second)) *
            2 *
            math.pi) /
        86400;

    return -time;
  }

  double caltime({required TimeOfDay time}) {
    double rangetime =
        ((time.hour * 3600 + time.minute * 60) * 2 * math.pi) / 86400;
    return rangetime;
  }

  @override
  void paint(Canvas canvas, Size size) {
    const List<Color> clockcolor = [Color(0xFFfc9d9a), Color(0xFF83Af9b)];
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);

    var radius = math.min(centerX, centerY);
    var radiusedge = radius + 3;
    var linerange = (size.height / 2) - radius;

    //paint style data
    var paintc1 = Paint()..color = Theme.of(context).toggleableActiveColor;
    var paintc2 = Paint()
      ..color = Colors.grey
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke;
    var paintline = Paint()
      ..color = Color.fromARGB(166, 115, 115, 115)
      ..strokeWidth = 3;

    var paintcirclebackground = Paint()
      ..color = Theme.of(context).backgroundColor;
    double checkclockvalue(
        //length of clock
        {required TimeOfDay starttime,
        required TimeOfDay endtime}) {
      if (starttime.hour > endtime.hour) {
        return ((2 * math.pi) -
            caltime(time: starttime) +
            caltime(time: endtime));
      } else if (starttime.hour == endtime.hour) {
        if (starttime.minute > endtime.minute) {
          return ((2 * math.pi) -
              caltime(time: starttime) +
              caltime(time: endtime));
        } else if (starttime.minute < endtime.minute) {
          return (caltime(time: endtime) - caltime(time: starttime));
        } else {
          return 0;
        }
      } else {
        return (caltime(time: endtime) - caltime(time: starttime));
      }
    }

    Offset convert(
        {required double angle,
        required double radius,
        required Offset center}) {
      var x = radius * math.cos(angle) + center.dx;
      var y = radius * math.sin(angle) + center.dy;

      return Offset(x, y);
    }

    void BuildPaint() {
      var longmodels = <models_clock>[];
      List<models_clock> pointmodels = [];
      for (models_clock element in models) {
        if (element.starttime.minute == element.endtime.minute &&
            element.starttime.hour == element.endtime.hour) {
          pointmodels.add(element);
        } else {
          longmodels.add(element);
        }
      }
      setter(longmodels.length);
      int lenght = longmodels.length;
      int i = lenght;
      for (models_clock element in longmodels) {
        var _stroksize = (radius / (lenght + 1));
        var radiuscircle = ((radius) / (lenght + 1)) * i + _stroksize / 2;
        Paint paint = Paint()
          ..color = element.color
          ..style = PaintingStyle.stroke
          ..strokeWidth = _stroksize - 1;

        canvas.drawArc(
            Rect.fromCenter(
                center: center,
                width: radiuscircle * 2,
                height: radiuscircle * 2),
            -caltime(time: element.starttime) + timenow() + startpos,
            -checkclockvalue(
                starttime: element.starttime, endtime: element.endtime),
            false,
            paint);
        i -= 1;
      }
      for (models_clock element in pointmodels) {
        Paint paint = Paint()
          ..color = element.color
          ..strokeWidth = 3;

        /* canvas.drawLine(
                convert(
                    angle: -caltime(time: element.starttime) +
                        timenow() +
                        startpos,
                    radius: radius,
                    center: center),
                center,
                paint);*/
        canvas.drawCircle(
            convert(
                angle: -caltime(time: element.starttime) + timenow() + startpos,
                radius: radiusedge,
                center: center),
            7,
            paint);
      }
    }

    ///////text painter ///
    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: 30,
    );

    void BuildLine({required int dot}) {
      var elementlength = pointelement >= 3 ? pointelement + 1 : 4;
      canvas.drawLine(
          Offset(size.width / 2 - radius, size.height / 2), center, paintline);
      canvas.drawCircle(
          Offset(size.width / 2 - radius - 5, size.height / 2), 8, paintc1);

      canvas.drawCircle(center, radius / (elementlength), paintc1);
    }

    ////////build
    ///

    canvas.drawArc(
        Rect.fromCenter(
            center: center, width: radiusedge * 2, height: radiusedge * 2),
        0,
        2 * math.pi,
        false,
        paintc2..strokeWidth = 4);

    //canvas.drawCircle(center, radius, Paint()..color = Colors.grey);

    //draw line number
    for (int i = 0; i < 12; i++) {
      if (i % 3 == 0) {
        canvas.drawLine(
            convert(
                angle: timenow() + i * (math.pi / 6),
                radius: radius * 9 / 10,
                center: center),
            center,
            paintline..strokeWidth = 2);
      } else {
        canvas.drawLine(
            convert(
                angle: timenow() + i * (math.pi / 6),
                radius: radius * 7 / 10,
                center: center),
            center,
            paintline..strokeWidth = 1);
      }
    }
    BuildPaint();
    BuildLine(dot: 10);

    var timenum = [24, 6, 12, 18];
    for (int i = 0; i < 4; i++) {
      canvas.save();

      var angle = timenow() -((i) * (math.pi / 2));

      final textSpan = TextSpan(
        text: timenum[i].toString(),
        style: Theme.of(context).textTheme.labelSmall,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: size.width,
      );
      var d = textPainter.width;

      final offset =
          convert(angle: angle, radius: radiusedge + d, center: center);
      final pivot = offset;
      canvas.translate(pivot.dx, pivot.dy);
      canvas.rotate(0);
      canvas.translate(-pivot.dx, -pivot.dy);
      //canvas.drawCircle(offset, 3, paintc1);

      textPainter.paint(canvas,
          Offset(offset.dx - (d / 2), offset.dy - textPainter.height / 2));
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

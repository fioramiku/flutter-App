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
                
                  _selectday = state.selectday;

                  return CustomPaint(
                    painter: Clock(
                        models: state.mclock![_selectday] ?? [],
                        startpos: animation.value,
                        now: nowtime),
                    child: Container(),
                  );
              
              },
            ),
            Center(
              child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: CustomShadow,
                    color: primarycolor,
                  )),
            )
          ],
        ));
  }
}

class Clock extends CustomPainter {
  final startpos;
  final List<models_clock> models;
  final DateTime now;
  Clock({required this.startpos, required this.models, required this.now});

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

    var paintfill = Paint()..color = Color.fromARGB(255, 63, 60, 100);
    var paintc1 = Paint()..color = Color(0xFFF67280);
    var paintc2 = Paint()
      ..color = Color.fromARGB(84, 255, 255, 255)
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke;
    var paintline = Paint()
      ..color = Color(0xFFF67280)
      ..strokeWidth = 2;
    var paintcircleline = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    var paintcirclebackground = Paint()..color = primarycolor;
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
      int lenght = models.length;
      int i = lenght;

      for (models_clock element in models) {
        var radiuscircle = ((radius / 2) / lenght) * i + radius / 2;
        Paint paint = Paint()..color = element.color;
        if (element.starttime.minute != element.endtime.minute ||
            element.starttime.hour != element.endtime.hour) {
          canvas.drawArc(
              Rect.fromCenter(
                  center: center,
                  width: radiuscircle * 2,
                  height: radiuscircle * 2),
              -caltime(time: element.starttime) + timenow() + startpos,
              -checkclockvalue(
                  starttime: element.starttime, endtime: element.endtime),
              true,
              paint);
          i -= 1;
        } else {
          lenght -= 1;
          i -= 1;
        }
        for (models_clock element in models) {
          if (element.starttime.minute == element.endtime.minute &&
              element.starttime.hour == element.endtime.hour) {
            Paint paint = Paint()
              ..color = element.color
              ..strokeWidth = 3;

            canvas.drawLine(
                convert(
                    angle: -caltime(time: element.starttime) +
                        timenow() +
                        startpos,
                    radius: radius,
                    center: center),
                center,
                paint);
          }
        }
      }
    }

    void BuildLine({required int dot}) {
      canvas.drawLine(
          Offset(size.width / 2 - radius, size.height / 2), center, paintline);
      canvas.drawCircle(Offset(size.width / 2 - radius-5, size.height / 2), 8,
          paintc1);
     
    }

    ////////build

    canvas.drawArc(
        Rect.fromCenter(
            center: center, width: radiusedge * 2, height: radiusedge * 2),
        0,
        2 * math.pi,
        false,
        paintc2);
    canvas.drawCircle(center, radius, Paint()..color = primarycolor);
    BuildPaint();
    BuildLine(dot: 10);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

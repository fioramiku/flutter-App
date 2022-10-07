import 'package:abc/database/base_data_tool.dart';
import 'package:abc/views/home_page/widget_item.dart';
import 'package:abc/views/home_page/widget_tool/time_separate/time_separate.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../plan_main/bloc/timemanage_bloc.dart';

class Home_page extends StatefulWidget {
  const Home_page({Key? key}) : super(key: key);

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  //stuck tool
  List<Widget> toolwidget = [SizedBox(), Timeseparate_tool()];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimemanageBloc, TimemanageState>(
      builder: (context, state) {
        Widget checktool({required int toolnum}) {
          return toolwidget[toolnum];
        }

        return Scaffold(
            extendBody: true,
            body: Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    
                    child: Text("Now Work:"),
                  ),
                  checktool(toolnum: 1),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CardItem(
                      title: "Hello",
                      textbody: "hello",
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }
}

class CardItem extends StatelessWidget {
  final String title;
  final String textbody;
  const CardItem({Key? key, required this.title, required this.textbody})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: darkTheme()
        ..copyWith(
          shadowColor: Colors.transparent,
        ),
      child: OpenContainer(
          tappable: false,
          closedColor: Colors.transparent,
          closedElevation: 0,
          openColor: Colors.transparent,
          openElevation: 0,
          closedBuilder: ((context, OpenContainer) => Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                    height: MediaQuery.of(context).size.height / 4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.2), BlendMode.dstATop),
                        image: NetworkImage(
                            "https://images.axa-contento-118412.eu/ktaxa/1e3533d0-ea5a-4e27-8bc9-eee3a8375edf_Smart+working+photo.jpg?auto=compress,format"),
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                    child: Stack(children: [
                      Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Tip for Study',
                            style: Theme.of(context).textTheme.titleLarge,
                          )),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: ElevatedButton(
                                onPressed: OpenContainer,
                                child: Text("discover"))),
                      ),
                    ])),
              )),
          openBuilder: (context, action) {
            var text2 = Text(
                        """ we are here to share some beneficial study tips that can help you develop a strong foundation to perform well on your exams.
            
            1. Study in manageable blocks of time.
            
            2. Create a consistent study schedule.
            
            3. Make connections between your various study topics.
            
            4. Use flashcards rather than just rereading your notes.
            
            5. Set specific goals for each study session.
            
            6. Explain the concepts you’re learning out loud.
            
            7. Test yourself with practice questions.
            
            8. Find study environments where you can be productive.
            
            9. Don’t listen to distracting music while you study.
            
            10. Put your cell phone away while you study.
            
            """);
            return Scaffold(
                body: CustomScrollView(slivers: <Widget>[
                  SliverWidget(
                      centerTitle: false,
                      src:
                          "https://images.axa-contento-118412.eu/ktaxa/1e3533d0-ea5a-4e27-8bc9-eee3a8375edf_Smart+working+photo.jpg?auto=compress,format",
                      text: "Tip for Study"),
                      
                  SliverToBoxAdapter(
                      child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(500)),
                    margin: EdgeInsets.all(20),
                    child: text2,
                  ))
                ]),
              
              );
          }),
    );
  }
}

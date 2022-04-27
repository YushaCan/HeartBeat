import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat/Antreman2/Widgets/ExercisesWidget.dart';
import 'package:heart_beat/Antreman2/Widgets/LineChartWidget.dart';

class ExerciseHomePage extends StatelessWidget {
  const ExerciseHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Container(
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            expandedHeight: 300.0,
            flexibleSpace: FlexibleSpaceBar(
              background: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(
                  "https://firebasestorage.googleapis.com/v0/b/heartbeat-cbae0.appspot.com/o/assets%2Ficons%2FWorkout%20Customizable%20Isometric%20Illustrations%20_%20Amico%20Style.png?alt=media&token=ec98765c-28af-43f0-8547-379ec5cc58a2",
                  height: 200,width: 200,fit: BoxFit.fill,),
              ),
            ),
          ),
          ExercisesWidget(),
        ],
      ),
    ),
  );

  SliverAppBar buildAppBar(BuildContext context) => SliverAppBar(
    flexibleSpace: FlexibleSpaceBar(background: LineChartWidget()),
    expandedHeight: MediaQuery.of(context).size.height * 0.5,
    stretch: true,
    title: Text('Statistics'),
    centerTitle: true,
    pinned: true,
    leading: Icon(Icons.menu),
    actions: [
      Icon(Icons.person, size: 28),
      SizedBox(width: 12),
    ],
  );
}

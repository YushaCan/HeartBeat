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
          buildAppBar(context),
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

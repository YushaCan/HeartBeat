import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat/Antreman/Model/exercise.dart';
import 'package:heart_beat/Antreman/Widget/VideoControlsWidget.dart';
import 'package:heart_beat/Antreman/Widget/VideoPlayerWidget.dart';

class ExercisePage extends StatefulWidget {
  final exerciseSet;

  const ExercisePage({
    @required this.exerciseSet,});

  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {

  final controller = PageController();
  late Exercise currentExercise;
  @override
  void initState(){
    super.initState();
    currentExercise = widget.exerciseSet.exercises.first;
  }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.transparent,
      title: Text(currentExercise.name),
      centerTitle: true,
      elevation: 0,
    ),
    extendBodyBehindAppBar: true,
    body: Stack(
      children: [
        buildVideos(),
        Positioned(
          bottom: 20,
            left: 50,
            child: buildVideoControllers()
        ),
      ],
    ),
  );

  Widget buildVideos() => PageView(
    controller: controller,
    onPageChanged: (index) => setState(() {
      currentExercise = widget.exerciseSet.exercises[index];
    }),
    children: widget.exerciseSet.exercises
        .map<Widget>((exercise)=> VideoPlayerWidget(
        exercise,
        onInitialized: ()=>setState(() {})),)
        .toList()
  );

  Widget buildVideoControllers() => VideoControlsWidget(
    exercise: currentExercise,
    onTogglePlaying: (isPlaying) {},
    onNextVideo: () {},
    onRewindVideo: () {},
  );
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat/Antreman2/Pages/ExercisesOfSetPage.dart';
import 'package:heart_beat/Antreman2/models/exerciseSet.dart';

class ExerciseSetWidget extends StatelessWidget {
  final ExerciseSet exerciseSet;
  const ExerciseSetWidget({
    required this.exerciseSet,
  });

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: () {
      print("i am tapped");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ExercisesOfSetPage(exercises: exerciseSet.exercises!)),
      );
    },
    child: Container(
      padding: const EdgeInsets.all(16),
      height: 100,
      decoration: BoxDecoration(
        color: exerciseSet.color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(flex: 3, child: buildText()),
          Expanded(child: Image.asset(exerciseSet.imageUrl))
        ],
      ),
    ),
  );

  Widget buildText() {
    final exercises = exerciseSet.exercises!.length.toString();
    final minutes = "test";
    final name = exerciseSet.name;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "$name",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
        SizedBox(height: 10),
        Text('$exercises Exercises $minutes Mins'),
      ],
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat/Antreman2/models/exercise.dart';

class ExercisesOfSetPage extends StatelessWidget {
  final List<Exercise> exercises;
  const ExercisesOfSetPage({
    required this.exercises,
  });
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () {

    },
    child: Container(
      padding: const EdgeInsets.all(16),
      height: 100,
      decoration: BoxDecoration(
        color: Colors.purple.shade100.withOpacity(0.6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(flex: 3, child: buildText()),
          Expanded(child: Image.asset(exercises[0].videoUrl!))
        ],
      ),
    ),
  );

  Widget buildText() {
    final exercises = this.exercises.length.toString();
    final minutes = this.exercises[0].duration;
    final name = this.exercises[0].name;
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

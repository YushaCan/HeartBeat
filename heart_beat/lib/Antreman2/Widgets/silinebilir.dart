import 'package:flutter/cupertino.dart';
import 'package:heart_beat/Antreman2/Pages/ExercisesOfSetPage.dart';
import 'package:heart_beat/Antreman2/models/exercise.dart';

class ExercisesOfSetWidget extends StatefulWidget {
  //const ExercisesOfSetWidget({Key? key}) : super(key: key);
  final List<Exercise> exercises;
  const ExercisesOfSetWidget({required this.exercises,});
  @override
  _ExercisesOfSetWidgetState createState() => _ExercisesOfSetWidgetState();
}

class _ExercisesOfSetWidgetState extends State<ExercisesOfSetWidget> {
  get exercises => null;
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            SizedBox(height: 8,),
            SizedBox(height: 8,),
            buildWorkouts(),
          ],
        ),
      ),
    );
  }

  Widget buildWorkouts() => GestureDetector(
    child: Column(
      children: [
        Column(
          children: this.exercises.map((exerciseSet) => Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ExercisesOfSetPage(exercises: this.exercises,)),
          ).toList(),)
      ],
    ),
  );
}

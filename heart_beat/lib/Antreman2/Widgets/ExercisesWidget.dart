import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat/Antreman2/firebasedata/exerciseSetdata.dart';
import 'package:heart_beat/Antreman2/models/exerciseSet.dart';

import 'ExerciseSetWidget.dart';

class ExercisesWidget extends StatefulWidget {
  const ExercisesWidget({Key? key}) : super(key: key);

  @override
  _ExercisesWidgetState createState() => _ExercisesWidgetState();
}

class _ExercisesWidgetState extends State<ExercisesWidget> {

  ExerciseType selectedType = ExerciseType.low;
  List<ExerciseSet> exerciseSets = [];
  var length= 0;
  @override
  void didChangeDependencies() async{
    super.didChangeDependencies();
    exerciseSets = await showExerciseSetData();
    super.setState(() {});
    print("i am from ExercisesWidget");
    print(exerciseSets.length);
    length = exerciseSets.length;
  }
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
        padding: const EdgeInsets.all(16),
        sliver: SliverList(
          delegate: SliverChildListDelegate(
            [
              SizedBox(height: 8,),
              Text(
                  'Exercises',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),
              ),
              SizedBox(height: 8,),
               buildDifficultyLevel(),
              SizedBox(height: 8,),
              buildWorkouts(),
            ],
          ),
        ),);
  }

  Widget buildDifficultyLevel() {
    return Row(
      children: ExerciseType.values.map(
              (type) {
                final name = getExerciseName(type);
                final fontWeight=
                selectedType == type? FontWeight.bold : FontWeight.normal;
                return Expanded(
                  child: Center(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: ()=> setState(() {
                        selectedType = type;
                      }),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          name,
                          style: TextStyle(fontWeight: fontWeight,fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
    );
  }

  void swipeFunction(DragEndDetails dragEndDetails){
    final selectedIndex = ExerciseType.values.indexOf(selectedType);
    final hasNext = selectedIndex< ExerciseType.values.length;
    final hasPrevious = selectedIndex > 0;

    setState(() {
      if(dragEndDetails.primaryVelocity! < 0 && hasNext){
        final nextType = ExerciseType.values[selectedIndex+1];
        selectedType = nextType;
      }

      if(dragEndDetails.primaryVelocity! > 0 && hasPrevious){
        final previousType = ExerciseType.values[selectedIndex-1];
        selectedType = previousType;
      }
    });
  }

  Widget buildWorkouts() => GestureDetector(
      onHorizontalDragEnd: swipeFunction,
      child: Column(
        children: [
          Column(
            children: exerciseSets.map((exerciseSet) => Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ExerciseSetWidget(exerciseSet: exerciseSet)),
            ).toList(),)
        ],
      ),
  );

}



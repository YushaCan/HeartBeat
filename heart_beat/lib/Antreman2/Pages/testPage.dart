import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat/Antreman2/firebasedata/exerciseSetdata.dart';
import 'package:heart_beat/Antreman2/models/exerciseSet.dart';

class testWidget extends StatefulWidget {

  const testWidget({Key? key}) : super(key: key);


  @override
  _testWidgetState createState() => _testWidgetState();
}

class _testWidgetState extends State<testWidget> {
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
    return Scaffold(
      body: Column(
        children: [
          Text(length.toString()),
        ],
      ),
    );
  }
}

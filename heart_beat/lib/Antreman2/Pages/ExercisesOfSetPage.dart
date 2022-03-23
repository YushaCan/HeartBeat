import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat/Antreman2/models/exercise.dart';

import 'ExerciseVideo.dart';

class ExercisesOfSetPage extends StatelessWidget {
  //const ExercisesOfSetPage({Key? key, required this.exercises}) : super(key: key);
  final List<Exercise> exercises;
  const ExercisesOfSetPage({required this.exercises,});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Exercises "
        ),
      ),
      body: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 10),
            itemCount: this.exercises.length,
            itemBuilder: (context, index){
              return InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ExerciseVideo(url: this.exercises[index].videoUrl!,)),
                  );
                },
                child: SizedBox(
                  width: 300.0,
                  height: 100.0,
                  child: Card(
                    shadowColor: Colors.pinkAccent,
                    color: Colors.blueAccent.shade100,
                    child: Center(
                      child: Text(
                        this.exercises[index].name!,
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                      ), //Text
                    ), //Center
                  ), //Card
                ), //SizedBox
              );
            }),
    );
  }


}

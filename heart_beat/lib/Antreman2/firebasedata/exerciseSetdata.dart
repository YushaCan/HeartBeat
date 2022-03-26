import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat/Antreman2/data/ExerciseSetDesign.dart';
import 'package:heart_beat/Antreman2/models/exercise.dart';
import 'package:heart_beat/Antreman2/models/exerciseSet.dart';

Future<List<ExerciseSet>> showExerciseSetData () async {
  List<ExerciseSet> exerciseSet = [];
  int count=1;
  int count1=0;
  DatabaseReference ref = FirebaseDatabase.instance.ref("EXERCISES");
  await ref.once().then((value){

    value.snapshot.children.forEach((element) { //core legs
      ExerciseSet SingleExerciseSet=new ExerciseSet(imageUrl: '',iconUrl: '');
      List<Exercise> exercises = [];
      SingleExerciseSet.name = element.key!;
      SingleExerciseSet.id = 0;
      SingleExerciseSet.exerciseType = ExerciseType.low;
      SingleExerciseSet.imageUrl = ExerciseImages[count1];
      SingleExerciseSet.color = ExerciseColors[count1];
      SingleExerciseSet.exercises?.clear();
        element.children.forEach((element) {
          //{duration: 30, set: 1, name: jump in place, isDone: 0, URL: https://firebasestorage.googleapis.com/v0/b/heartbeat-cbae0.appspot.com/o/assets%2Fcore%2F5.gif?alt=media&token=a389e861-904d-4728-8975-3d11674edc26}
          Exercise SingleExercise =  new Exercise();
          print(element.value);
          element.children.forEach((element) {// 30 1 jump in place
            if(count==1){
              SingleExercise.duration= element.value.toString();
            }
            else if(count==2){
              SingleExercise.isDone= element.value.toString();
            }
            else if(count==3){
              SingleExercise.iconUrl= element.value.toString();
            }
            else if(count==4){
              SingleExercise.name= element.value.toString();
            }
            else if(count==5){
              SingleExercise.set= element.value.toString();
            }
            else if(count==6){
              SingleExercise.videoUrl= element.value.toString();
            }
            count++;
          });
          count=1;
          exercises.add(SingleExercise);
          SingleExerciseSet.exercises = exercises;
        });
      exerciseSet.add(SingleExerciseSet);
      count1++;
    });
  });
  return exerciseSet;
}
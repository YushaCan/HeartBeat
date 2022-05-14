import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:heart_beat/Antreman2/models/exercise.dart';
import 'package:heart_beat/Antreman2/models/isDoneExercise.dart';

Future<List<isDoneExercise>> showIsDoneExercisesSetData () async {
  List<isDoneExercise> exercises= [];
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  final current_uid = user?.uid;

  DatabaseReference ref = FirebaseDatabase.instance.ref("USERS/${current_uid}/EXERCISES");
  await ref.once().then((value){
    value.snapshot.children.forEach((element) { //core legs
      element.children.forEach((element) {
        element.children.forEach((element) {
          isDoneExercise SingleExercise= new isDoneExercise();
          element.children.forEach((element) {
            if(element.key.toString() == "set"){
              SingleExercise.set = element.value.toString();
            }
            else if(element.key.toString()=="exNo"){
              SingleExercise.exNo =element.value.toString();
            }
            else if(element.key.toString()=="isDone"){
              SingleExercise.isDone = element.value.toString();
            }
          });
          exercises.add(SingleExercise);
        });
      });
    });
  });

  return exercises;
}

Future<List<Exercise>> showData () async {

  int count=1;
  List<Exercise> exercises = [];
  DatabaseReference ref = FirebaseDatabase.instance.ref("EXERCISES/CORE");
 // DatabaseEvent event =  await ref.once() ;
  await ref.once().then((value){
    value.snapshot.children.forEach((element) {
      Exercise exercise=new Exercise(name: "",duration: "",noOfReps: "",videoUrl: "",isDone: "",set: "");
      element.children.forEach((element) {
        if(count==1){
          exercise.duration= element.value.toString();
        }
        else if(count==2){
          exercise.set= element.value.toString();
        }
        else if(count==3){
          exercise.name= element.value.toString();
        }
        else if(count==4){
          exercise.isDone= element.value.toString();
        }
        else if(count==5){
          exercise.videoUrl= element.value.toString();
        }
        count++;
      });
      exercises.add(exercise);
      //print(exercises.length);
      count=1;
    });
  });
  return exercises;
}
import 'package:heart_beat/Antreman2/firebasedata/exerciseSetdata.dart';
import 'package:heart_beat/Antreman2/models/exerciseSet.dart';

void ExercisesCount() async {
  List<ExerciseSet> map1 = await showExerciseSetData();
  print(map1.length);
  for(int i=0; i<map1.length; i++){
    for(int j=0; j<map1[i].exercises!.length; j++){
      print(map1[i].exercises!.length);
      print(map1[i].name);
      print(map1[i].exerciseType);
      print(map1[i].color);
      print(map1[i].imageUrl);
    }
  }
}

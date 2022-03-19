import 'package:flutter/material.dart';
import 'exercise.dart';

enum ExerciseType { low, mid, hard }

String getExerciseName(ExerciseType type) {
  switch (type) {
    case ExerciseType.hard:
      return 'Hard';
      break;
    case ExerciseType.mid:
      return 'Medium';
      break;
    case ExerciseType.low:
      return 'Easy';
      break;
    default:
      return 'All';
      break;
  }
}

class ExerciseSet {
  late String? name;
  late  int? id;
  late  List<Exercise>? exercises;
  late  ExerciseType? exerciseType;
  late  Color? color;
  late String imageUrl;

   ExerciseSet({
      this.name,
      this.id,
      this.exercises,
      this.exerciseType,
      this.color,
      required this.imageUrl
  });

}
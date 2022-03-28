import 'package:flutter/material.dart';

class Gamification {
  // This variables will pulling from firebase
  // For the level of user and user's experience point
  static int level = 1;
  static double experiencePoint = 500;
  static double expForOtherLevel = 1000;

  // FOR THE RANK OF THE USER
  static bool isBronze = false;
  static bool isSilver = false;
  static bool isGold = true;
  static bool isDiamond = false;
  static Color Rank() {
    Color color = Colors.black;
    if (isBronze) {
      color = Colors.brown;
    } else if (isSilver) {
      color = Colors.blueGrey;
    } else if (isGold) {
      color = Colors.yellow;
    } else if (isDiamond) {
      color = Colors.cyanAccent;
    }
    return color;
  }
  //////////////////////////////
}

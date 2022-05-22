import 'package:flutter/material.dart';
import 'package:heart_beat/MainPages/MainMenu.dart';

class Gamification {
  // This variables will pulling from firebase
  // For the level of user and user's experience point
  static int level = 1;
  static double experiencePoint = 0;
  static double expForOtherLevel = 500;
  static bool levelCongratulations = false;
  static double LevelUp() {
    levelCongratulations = false;
    if (experiencePoint >= expForOtherLevel) {
      // LEVEL UP CONGRATULATIONS
      levelCongratulations = true;
      ///////////////////////////
      level++;
      expForOtherLevel *= 3 / 2;
      experiencePoint = 0;
    }

    return experiencePoint / expForOtherLevel;
  }

  // FOR THE RANK OF THE USER
  static bool isBronze = false;
  static bool isSilver = false;
  static bool isGold = false;
  static bool isDiamond = true;
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

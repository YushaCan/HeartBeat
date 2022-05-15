import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:heart_beat/Gamification/Gamification.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:line_icons/line_icons.dart';

class WaterPage extends StatelessWidget {
  const WaterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Water Management",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Water Management"),
          backgroundColor: Color.fromRGBO(0, 31, 235,0.6),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: WaterPageContent(),
      ),
    );
  }
}

class WaterPageContent extends StatefulWidget {
  WaterPageContent({Key? key}) : super(key: key);

  @override
  State<WaterPageContent> createState() => _WaterPageContentState();
}

class _WaterPageContentState extends State<WaterPageContent>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  // Water amount should consumed
  static double waterAmount = 0;
  //////////////////////////////
  // User can click button when it is not %100
  static bool canClick = true;

  void GainExperiencePoint() {
    // GAIN EXPERIENCE POINTS
    Gamification.experiencePoint += 100;
    /////////////////////////
    // Disable button when water management reached %100
    if (waterAmount >= 0.8) {
      setState(() {
        canClick = false;
      });
    } else {
      setState(() {
        canClick = true;
      });
    }
    ////////////////////////////////////////////////////
    setState(() {
      waterAmount += 0.1;
      animationController.animateTo(waterAmount);
    });
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    animationController.addListener(() => setState(() {}));
    // CHANGE THE VALUE IN THE animeteTo dynamically with respect to consumed water
    if (animationController.value <= waterAmount) {
      animationController.animateTo(waterAmount);
    }

    //////////////////////////////////////////////////////////////////////////////
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    // VALUE PERCENT
    final percentage = animationController.value * 100;
    ///////////////
    return Center(
      child: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 350, left: 115),
            child: ElevatedButton(
              onPressed: canClick ? GainExperiencePoint : null,
              child: Icon(
                Icons.local_drink,
                size: 35,
              ),
              style: ElevatedButton.styleFrom(
                  // padding: EdgeInsets.only(left: 70),
                  shape: const CircleBorder(),
                  fixedSize: Size(70, 70)),
            ),
          ),
          SizedBox(
            width: 300,
            height: 300,
            child: LiquidCircularProgressIndicator(
              value: animationController.value,
              direction: Axis.vertical,
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation(Color.fromRGBO(0, 31, 235,0.6)),
              center: Text(
                "${percentage.toStringAsFixed(0)}%",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:heart_beat/Gamification/Gamification.dart';
import 'package:heart_beat/XP/actions.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:line_icons/line_icons.dart';

import 'MainMenu.dart';

class WaterPage extends StatelessWidget {
  const WaterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Profile Page",
      home: new WillPopScope(
        child: Scaffold(
          body: WaterPageContent(),
        ),
        onWillPop: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainMenu()),
          );
          return true;
        },
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
  double? waterAmount = 0.0;
  //////////////////////////////
  // User can click button when it is not %100
  static bool canClick = true;

  void GainExperiencePoint() async{
    // GAIN EXPERIENCE POINTS

    waterAmount = await showWater();
    /////////////////////////
    // Disable button when water management reached %100
    if (waterAmount! > 0.8) {
      setState(() {
        canClick = false;
      });
    } else {
      setState(() {
        canClick = true;
      });
    }
    ////////////////////////////////////////////////////
    setState((){
      print("i am setstate from gain function");
      EarnXp(100);
      AddWater(0.1);
      animationController.addListener(() => setState(() {}));
      animationController.animateTo(waterAmount!);
      if (animationController.value <= waterAmount!) {
        animationController.animateTo(waterAmount!);
      }
    });
  }

  @override void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("i am did changes");
    waterAmount = await showWater();
    print(waterAmount);
    animationController.addListener(() => setState(() {}));
    if (animationController.value <= waterAmount!) {
      animationController.animateTo(waterAmount!);
    }
    super.setState(() {});
  }
  @override
  void initState() {
    super.initState();
    print("i am initstate");
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
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
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainMenuPage()),
        );
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: Text("Water Page"),
          titleTextStyle: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainMenuPage()),
              );
            },
          ),
        ),
        body: Center(
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
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
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
        ),
      ),
    );
  }
}

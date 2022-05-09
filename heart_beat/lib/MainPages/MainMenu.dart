import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:heart_beat/Challenge/friendsWidget.dart';
import 'package:heart_beat/Gamification/Gamification.dart';
import 'package:heart_beat/MainPages/Leaderboard.dart';
import 'package:heart_beat/MainPages/ProfilePage.dart';
import 'package:heart_beat/MainPages/WaterPage.dart';
import 'package:heart_beat/MainPages/main.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../Antreman2/Pages/ExerciseHomePage.dart';
import '../Challenge/ChallengeFirebaseData.dart';
import '../Challenge/challengeWidget.dart';
import '../FriendShip/FriendRequestsWidget.dart';
import '../UYELIK/LoginPage.dart';
import 'FriendsList.dart';
import 'dart:math' as math;
import 'package:line_icons/line_icons.dart';

class MainMenuPage extends StatelessWidget {
  MainMenuPage({Key? key}) : super(key: key);
  // FOR OPEN DRAWER PROGRAMMATICALLY
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Heart Beat',
        home: Scaffold(
          key: _key,
          drawer: SideBar(),
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(0, 129, 235, 92),
            // For Friends List on AppBar
            leading: IconButton(
              // Open Friends list
              onPressed: () {
                print('FRIENDS LIST OPENED');
                _key.currentState!.openDrawer();
              },
              icon: Icon(Icons.people),
              iconSize: 30,
            ),
            title: Text('Heart Beat'),
            titleTextStyle: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
            // For Profile Page on AppBar
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: IconButton(
                  onPressed: () {
                    print('PROFILE PAGE OPENED');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Profile()),
                    );
                  },
                  icon: Icon(Icons.person),
                  iconSize: 30,
                ),
              ),
            ],
          ),
          body: MainMenu(),
        ));
  }
}

class MainMenu extends StatefulWidget {
  MainMenu({Key? key}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  double sliderValue = 0;
  // Each level's experience points & numbers
  double levelExp = Gamification.experiencePoint;
  double nextLevelExp = Gamification.expForOtherLevel;
  int currentLevel = Gamification.level;
  late int nextLevel = currentLevel + 1;
  //////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          // Level Progression Bar
          SizedBox(
              width: 400,
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Level Bar Codes
                  new LinearPercentIndicator(
                    width: 300,
                    animation: true,
                    animationDuration: 1500,
                    lineHeight: 25,
                    leading: new Text(
                      currentLevel.toString(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: new Text(
                      nextLevel.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    percent: levelExp / nextLevelExp,
                    linearStrokeCap: LinearStrokeCap.butt,
                    progressColor: Colors.yellow,
                  )
                ],
              )),
          // First Row
          Row(
            children: <Widget>[
              // TRAINING BUTTON
              SizedBox(
                height: 120,
                width: 120,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 6,
                    top: 20,
                  ),
                  // For Training Page
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromRGBO(0, 129, 235, 0.639)),
                    ),
                    child: Transform.rotate(
                      angle: math.pi / 4,
                      child: Icon(
                        LineIcons.dumbbell,
                        size: 85,
                      ),
                    ),
                    onPressed: () {
                      print("TRAINING PAGE OPENED");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ExerciseHomePage()),
                      );
                    },
                  ),
                ),
              ),
              // PEDOMETER BUTTON
              SizedBox(
                height: 120,
                width: 120,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 6,
                    top: 20,
                  ),
                  // For Pedometer Page
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromRGBO(0, 129, 235, 0.639)),
                    ),
                    child: Align(
                      alignment: Alignment(0.0, 0.0),
                      child: Transform.rotate(
                        angle: 0,
                        child: Icon(
                          LineIcons.shoePrints,
                          size: 70,
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FriendRequestsWidget(),));
                    },
                  ),
                ),
              ),
              // BMI (Body Mass Index) BUTTON
              SizedBox(
                height: 120,
                width: 120,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 5,
                    top: 20,
                    right: 5,
                  ),
                  // For BMI
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromRGBO(0, 129, 235, 0.639)),
                    ),
                    child: Icon(
                      //FontAwesomeIcons.weight,
                      LineIcons.weight,
                      size: 70,
                    ),
                    onPressed: () {
                      print("BMI PAGE OPENED");
                    },
                  ),
                ),
              ),
            ],
          ),
          // Second Row
          Row(
            children: <Widget>[
              // TRAININ BUTTON
              SizedBox(
                height: 130,
                width: 120,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 6,
                    top: 30,
                  ),
                  // For Training Page
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromRGBO(0, 129, 235, 0.639)),
                    ),
                    child: Icon(
                      LineIcons.tint,
                      size: 75,
                    ),
                    onPressed: () {
                      print("WATER PAGE OPENED");
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WaterPage()),
                      );
                    },
                  ),
                ),
              ),
              // PEDOMETER BUTTON
              SizedBox(
                height: 130,
                width: 120,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 6,
                    top: 30,
                  ),
                  // For Pedometer Page
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromRGBO(0, 129, 235, 0.639)),
                    ),
                    child: Icon(
                      LineIcons.fruitApple,
                      size: 75,
                    ),
                    onPressed: () {
                      print("FOOD PAGE OPENED");
                    },
                  ),
                ),
              ),
              // BMI (Body Mass Index) BUTTON
              SizedBox(
                height: 130,
                width: 120,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 5,
                    top: 30,
                    right: 5,
                  ),
                  // For BMI
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromRGBO(0, 129, 235, 0.639)),
                    ),
                    child: Icon(
                      LineIcons.heartbeat,
                      size: 75,
                    ),
                    onPressed: () {
                      print("HEART RATE PAGE OPENED");
                    },
                  ),
                ),
              ),
            ],
          ),
          // Third Row
          Row(
            children: <Widget>[
              // TRAININ BUTTON
              SizedBox(
                height: 130,
                width: 120,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 6,
                    top: 30,
                  ),
                  // For Training Page
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromRGBO(0, 129, 235, 0.639)),
                    ),
                    child: Icon(
                      LineIcons.trophy,
                      size: 75,
                    ),
                    onPressed: () {
                      print("LEADER BOARD PAGE OPENED");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LeaderBoardPage()),
                      );
                    },
                  ),
                ),
              ),
              // PEDOMETER BUTTON
              SizedBox(
                height: 130,
                width: 120,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 6,
                    top: 30,
                  ),
                  // For Pedometer Page
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromRGBO(0, 129, 235, 0.639)),
                    ),
                    child: Icon(
                      LineIcons.handshake,
                      size: 75,
                    ),
                    onPressed: () {
                      print("CHALLENGE PAGE OPENED");
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Friends()),
                      );
                    },
                  ),
                ),
              ),
              // BMI (Body Mass Index) BUTTON
              SizedBox(
                height: 130,
                width: 120,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 5,
                    top: 30,
                    right: 5,
                  ),
                  // For BMI
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromRGBO(0, 129, 235, 0.639)),
                    ),
                    child: Icon(
                      LineIcons.question,
                      size: 75,
                    ),
                    onPressed: () {
                      print("FAQ PAGE OPENED");
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

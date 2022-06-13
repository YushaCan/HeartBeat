import 'dart:async';
import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat/Challenge/AllReceivedChallenges.dart';
import 'package:heart_beat/Challenge/friendsWidget.dart';
import 'package:heart_beat/Gamification/Gamification.dart';
import 'package:heart_beat/MainPages/Leaderboard.dart';
import 'package:heart_beat/MainPages/ProfilePage.dart';
import 'package:heart_beat/MainPages/WaterPage.dart';
import 'package:heart_beat/XP/actions.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../Antreman2/ExerciseCounter/Counter.dart';
import '../Antreman2/Pages/ExerciseHomePage.dart';
import '../Challenge/senderReviewPage.dart';
import '../FriendShip/FriendRequestsWidget.dart';
import 'FriendsList.dart';
import 'dart:math' as math;
import 'package:line_icons/line_icons.dart';

import 'VegsFruits.dart';

class MainMenuPage extends StatelessWidget {
  MainMenuPage({Key? key}) : super(key: key);
  // FOR OPEN DRAWER PROGRAMMATICALLY
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Heart Beat',
      home: new WillPopScope(
        onWillPop: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainMenuPage()),
          );
          return true;
        },
        child: Scaffold(
          key: _key,
          drawer: SideBar(),
          appBar: AppBar(
            //backgroundColor: Color.fromRGBO(0, 31, 235, 0.6),
            backgroundColor: Colors.lightBlueAccent,
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FriendRequestsWidget()),
                    );
                  },
                  icon: Icon(Icons.add_alert),
                  iconSize: 30,
                ),
              ),
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
        ),
      ),
    );
  }
}

class MainMenu extends StatefulWidget {
  MainMenu({Key? key}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  double leftSpace = 4;

  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(hours: 24), (Timer t) => MarkAsNotDone());
    initController();
  }

  int? currentLevel = 0;
  int? nextLevel = 0;
  int? currentXp = 0;
  double expForOtherLevel = 0.0;
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    currentLevel = await showLevel();
    nextLevel = currentLevel! + 1;
    currentXp = await showXP();
    expForOtherLevel = currentXp! / 500;
    if (currentXp! >= 500 || expForOtherLevel >= 1.0) {
      AddLevel(1);
      XpSifirla();
      currentXp = 0;
      confettiController.play();
    }
    print("current xp is $currentXp");
    super.setState(() {});
  }

  //////////////////////////////////////////
  /////////////////////////////////////////////////////////
  late ConfettiController confettiController;
  void initController() {
    confettiController =
        ConfettiController(duration: const Duration(seconds: 3));
  }

  //////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Image(
            image: AssetImage("assets/background.jpg"),
          ),
          SizedBox(
            width: 1000,
            height: 1000,
            child: Image(
              image: AssetImage("assets/background.jpg"),
            ),
          ),
          Column(
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
                        width: 350,
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
                        percent: expForOtherLevel,
                        linearStrokeCap: LinearStrokeCap.butt,
                        progressColor: Colors.yellow,
                      )
                    ],
                  )),
              // First Row
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: leftSpace),
                  ),
                  // TRAINING BUTTON
                  SizedBox(
                    height: 140,
                    width: 190,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 8,
                        top: 20,
                      ),
                      // For Training Page
                      child: ElevatedButton(
                        style: ButtonStyle(
                          //backgroundColor: MaterialStateProperty.all<Color>(
                          //Color.fromRGBO(0, 31, 235, 0.6)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.lightBlueAccent,
                          ),
                        ),
                        child: Transform.rotate(
                          angle: math.pi / 4,
                          child: Icon(
                            LineIcons.dumbbell,
                            size: 100,
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
                    height: 140,
                    width: 190,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 8,
                        top: 20,
                      ),
                      // For Pedometer Page
                      child: ElevatedButton(
                        style: ButtonStyle(
                          //backgroundColor: MaterialStateProperty.all<Color>(
                          //  Color.fromRGBO(0, 31, 235, 0.6)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.lightBlueAccent,
                          ),
                        ),
                        child: Align(
                          alignment: Alignment(0.0, 0.0),
                          child: Transform.rotate(
                            angle: 0,
                            child: Icon(
                              LineIcons.clock,
                              size: 80,
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AllReceivedChallenges(),
                              ));
                        },
                      ),
                    ),
                  ),
                ],
              ),
              // Second Row
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: leftSpace),
                  ),
                  // TRAININ BUTTON
                  SizedBox(
                    height: 140,
                    width: 190,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 8,
                        top: 30,
                      ),
                      // For Training Page
                      child: ElevatedButton(
                        style: ButtonStyle(
                          // backgroundColor: MaterialStateProperty.all<Color>(
                          //   Color.fromRGBO(0, 31, 235, 0.6)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.lightBlueAccent,
                          ),
                        ),
                        child: Icon(
                          LineIcons.tint,
                          size: 90,
                        ),
                        onPressed: () {
                          print("WATER PAGE OPENED");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WaterPage()),
                          );
                        },
                      ),
                    ),
                  ),
                  // PEDOMETER BUTTON
                  SizedBox(
                    height: 140,
                    width: 190,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 8,
                        top: 30,
                      ),
                      // For Pedometer Page
                      child: ElevatedButton(
                        style: ButtonStyle(
                          //backgroundColor: MaterialStateProperty.all<Color>(
                          //  Color.fromRGBO(0, 31, 235, 0.6)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.lightBlueAccent,
                          ),
                        ),
                        child: Icon(
                          LineIcons.fruitApple,
                          size: 90,
                        ),
                        onPressed: () {
                          print("FOOD PAGE OPENED");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VegsFruits()),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              // Third Row
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: leftSpace),
                  ),
                  // TRAININ BUTTON
                  SizedBox(
                    height: 140,
                    width: 190,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 8,
                        top: 30,
                      ),
                      // For Training Page
                      child: ElevatedButton(
                        style: ButtonStyle(
                          //backgroundColor: MaterialStateProperty.all<Color>(
                          //  Color.fromRGBO(0, 31, 235, 0.6)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.lightBlueAccent,
                          ),
                        ),
                        child: Icon(
                          LineIcons.trophy,
                          size: 90,
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
                    height: 140,
                    width: 190,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 8,
                        top: 30,
                      ),
                      // For Pedometer Page
                      child: ElevatedButton(
                        style: ButtonStyle(
                          //backgroundColor: MaterialStateProperty.all<Color>(
                          //  Color.fromRGBO(0, 31, 235, 0.6)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.lightBlueAccent,
                          ),
                        ),
                        child: Icon(
                          LineIcons.handshake,
                          size: 90,
                        ),
                        onPressed: () {
                          print("CHALLENGE PAGE OPENED");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => senderReviewPage()),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          buildConfettiWidget(confettiController, pi / 1),
          buildConfettiWidget(confettiController, pi / 5),
        ],
      ),
    );
  }

  Align buildConfettiWidget(controller, double blastDirection) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConfettiWidget(
        maximumSize: Size(40, 40),
        shouldLoop: false,
        confettiController: controller,
        blastDirection: blastDirection,
        blastDirectionality: BlastDirectionality.explosive,
        maxBlastForce: 10, // set a lower max blast force
        minBlastForce: 8, // set a lower min blast force
        emissionFrequency: 1,
        numberOfParticles: 16, // a lot of particles at once
        gravity: 1,
      ),
    );
  }
}

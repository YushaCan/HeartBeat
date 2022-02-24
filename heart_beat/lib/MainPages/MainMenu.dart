import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class MainMenuPage extends StatelessWidget {
  const MainMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Heart Beat',
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(0, 129, 235, 92),
            // For Friends List on AppBar
            leading: IconButton(
              // Open Friends list
              onPressed: () {
                print('FRIENDS LIST OPENED');
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
  double levelExp = 100;
  int currentLevel = 9;
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
                      ),
                    ),
                    trailing: new Text(
                      nextLevel.toString(),
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    percent: 0.7,
                    linearStrokeCap: LinearStrokeCap.butt,
                    progressColor: Colors.yellow,
                  )
                ],
              )),
          // First Row
          Row(
            children: <Widget>[
              // TRAININ BUTTON
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
                    child: Icon(
                      Icons.fitness_center,
                      size: 75,
                    ),
                    onPressed: () {
                      print("TRAINING PAGE OPENED");
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
                    child: Icon(
                      Icons.fitness_center,
                      size: 75,
                    ),
                    onPressed: () {
                      print("PEDOMETER PAGE OPENED");
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
                      Icons.fitness_center,
                      size: 75,
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
                      Icons.fitness_center,
                      size: 75,
                    ),
                    onPressed: () {
                      print("WATER PAGE OPENED");
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
                      Icons.fitness_center,
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
                      Icons.fitness_center,
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
                      Icons.fitness_center,
                      size: 75,
                    ),
                    onPressed: () {
                      print("LEADER BOARD PAGE OPENED");
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
                      Icons.fitness_center,
                      size: 75,
                    ),
                    onPressed: () {
                      print("CHALLENGE PAGE OPENED");
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
                      Icons.fitness_center,
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

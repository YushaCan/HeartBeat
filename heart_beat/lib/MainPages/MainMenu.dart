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
    return Column(
      children: <Widget>[
        // Level Progression Bar
        SizedBox(
            width: 400,
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
      ],
    );
  }
}

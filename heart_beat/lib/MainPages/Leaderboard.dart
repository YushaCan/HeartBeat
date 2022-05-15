import 'dart:math';

import 'package:flutter/material.dart';

import 'ProfilePage.dart';

class LeaderBoardPage extends StatelessWidget {
  const LeaderBoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LeaderBoard Page',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(0, 31, 235,0.6),
          title: Text("Leader Board"),
          titleTextStyle: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        body: LeaderBoard(),
      ),
    );
  }
}

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({Key? key}) : super(key: key);

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  // FOR STATIC LEVEL INFORMATIONS. WILL PULL FROM DATABASE
  List<int> level = [];

  // FOR STATIC XP INFORMATIONS. WILL PULL FROM DATABASE
  List<int> xp = [];

  @override
  void initState() {
    super.initState();
    // FOR RANDOM LEVEL NUMBERS
    // RANDOMNESS WILL CHANGE WITH REAL DATABASE INFORMATIONS
    for (int i = 0; i < 20; i++) {
      level.add(Random().nextInt(100));
    }
    // FOR RANDOM XP NUMBERS
    // RANDOMNESS WILL CHANGE WITH REAL DATABASE INFORMATIONS
    for (int i = 0; i < 20; i++) {
      xp.add(Random().nextInt(10000));
    }
    SelectionSort(level);
    SelectionSort(xp);
  }

  void SelectionSort(List<int> levelInfo) {
    int minID;
    bool flag;
    for (int i = 0; i < levelInfo.length; i++) {
      minID = i;
      flag = false;
      for (int j = 0; j < levelInfo.length; j++) {
        if (levelInfo[j] < levelInfo[minID]) {
          minID = j;
          flag = true;
        }
        if (flag) {
          int temp;
          temp = levelInfo[minID];
          levelInfo[minID] = levelInfo[i];
          levelInfo[i] = temp;
        }
      }
    }
    print(levelInfo);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: Center(
              child: Image(
                width: 200,
                height: 175,
                image: AssetImage("assets/leaderboard.png"),
              ),
            ),
          ),
          // LEVEL AND XP TEXTS
          Padding(
            padding: EdgeInsets.only(left: 275),
            child: Row(
              children: <Widget>[
                Text("Level"),
                Padding(padding: EdgeInsets.only(left: 25)),
                Text("XP"),
              ],
            ),
          ),
          //////////////////////
          // USER LISTVIEW
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 20,
            itemBuilder: (BuildContext context, int index) {
              // EVERY ELEMENT OF THE LIST
              return Card(
                color: (index < 3) ? Colors.green : Colors.white,
                child: InkWell(
                  onTap: () {
                    // OPEN UP THE PROFILE PAGE OF SELECTED USER
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Profile()),
                    );
                  },
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        // THIS PROFILE PICTURE WILL BE PULL FROM THE DB
                        backgroundImage: AssetImage("assets/profilephoto.jpg"),
                      ),
                      Padding(padding: EdgeInsets.only(top: 40, left: 7)),
                      // Placement Numbers
                      Text(
                        "${index + 1}.",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          //color: (index + 1 > 3) ? Colors.black : Colors.green,
                        ),
                      ),
                      /////////////////////
                      Padding(padding: EdgeInsets.only(left: 20)),
                      ////////////////////
                      // USERNAMES
                      // WILL SORTING BY THEIR ==>
                      // 1. BY LEVELS
                      // 2. BY XPs
                      SizedBox(
                        width: 130,
                        height: 15,
                        child: Text(index < 4
                            ? "User ${index + 1}"
                            : "User123456789101112 ${index + 1}"),
                      ),
                      ////////////
                      // LEVEL DATA OF USERS
                      Padding(
                          padding: (index < 9)
                              ? EdgeInsets.only(left: 70)
                              : EdgeInsets.only(left: 60)),
                      Text("${level[index]}"), // THIS WILL PULL FROM DATABASE
                      // XP DATA OF USERS
                      Padding(padding: EdgeInsets.only(left: 33)),
                      Text("${xp[index]}"), // THIS WILL PULL FROM DATABASE
                      //////////////////
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

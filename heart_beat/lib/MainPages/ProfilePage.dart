import 'dart:ui';

import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Profile Page",
      home: Scaffold(
        body: ProfilePage(),
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // TO EDIT ABOUT ME
  // THIS WILL TAKE IT'S VALUE FROM FIREBASE AND REMAIN SAME
  static var aboutMeController = TextEditingController();
  ///////////////////////////////////////////////////////////
  // This values too will be taken from firebase
  int level = 9;
  String name = "Name";
  String surname = "Surname";
  String mail = "E-Mail";
  ////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 100)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 30),
              ),
              // PROFILE PHOTO AND NICK
              Stack(
                children: <Widget>[
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Image(
                      image: AssetImage("assets/profilephoto.jpg"),
                    ),
                  ),
                  Positioned(
                    left: 70,
                    bottom: 70,
                    child: Container(
                      width: 30,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: new BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        "$level",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(left: 10)),
              // NAME-SURNAME-EMAIL PART
              SizedBox(
                width: 190,
                height: 120,
                child: Column(
                  children: <Widget>[
                    // NAME
                    SizedBox(
                      width: 190,
                      height: 30,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          onSurface: Colors.white,
                          shadowColor: Color.fromARGB(0, 255, 255, 255),
                          side: BorderSide(
                            color: Colors.black,
                            width: 3,
                          ),
                        ),
                        onPressed: null,
                        // This child will be changed with user's name
                        child: Text(
                          "$name",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        /////////////////////////////////////////////
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    // SURNAME
                    SizedBox(
                      width: 190,
                      height: 30,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          onSurface: Colors.white,
                          shadowColor: Color.fromARGB(0, 255, 255, 255),
                          side: BorderSide(
                            color: Colors.black,
                            width: 3,
                          ),
                        ),
                        onPressed: null,
                        // This child will be changed with user's surname
                        child: Text(
                          "$surname",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        /////////////////////////////////////////////////
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    // E-MAIL
                    SizedBox(
                      width: 190,
                      height: 30,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          onSurface: Colors.white,
                          shadowColor: Color.fromARGB(0, 255, 255, 255),
                          side: BorderSide(
                            color: Colors.black,
                            width: 3,
                          ),
                        ),
                        onPressed: null,
                        // This child will be changed with user's surname
                        child: Text(
                          "$mail",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        /////////////////////////////////////////////////
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // ABOUT ME PART

          Container(
            padding: EdgeInsets.only(top: 30),
            width: 350,
            height: 300,
            child: TextField(
              controller: aboutMeController,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              minLines: 1,
              maxLines: 7,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'About me',
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'dart:io';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:heart_beat/Gamification/Gamification.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat/MainPages/MainMenu.dart';
import 'package:heart_beat/UYELIK/LoginPage.dart';

Future<void> _signOut() async {
  await FirebaseAuth.instance.signOut();
  runApp(new MaterialApp(
    home: new UserDataList(),
  ));
}

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Profile Page",
      home: new WillPopScope(
        child: Scaffold(
          body: ProfilePage(),
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

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // This values too will be taken from firebase
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  int level = Gamification.level;
  String name = "";
  String surname = "";
  String mail = "E-";
  ////////////////////////////////////////////
  // For the pick Profile Image
  File? _pickedImage;
  ////////////////////////////////////////////

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: Text("Profile Page"),
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
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              // PROFILE PHOTO AND NICK
              Stack(
                children: <Widget>[
                  Container(
                    child: CircleAvatar(
                      radius: 120,
                      backgroundColor: Gamification.Rank(),
                      child: CircleAvatar(
                        radius: 110,
                        backgroundImage: _pickedImage == null
                            ? AssetImage("assets/profilephoto.jpg")
                                as ImageProvider
                            : FileImage(_pickedImage!),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: ((builder) => bottomSheet()),
                        );
                      },
                      // PICK IMAGE BUTTON
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Color.fromARGB(0, 255, 255, 255),
                        child: Icon(
                          Icons.camera_alt,
                          size: 45,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                  ),
                  // LEVEL CIRCLE
                  Padding(
                    padding: EdgeInsets.only(
                      left: 185,
                    ),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.blue,
                      child: Text(
                        "$level",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 20)),
              // NAME-SURNAME-EMAIL PART
              SizedBox(
                width: 190,
                height: 120,
                child: Column(
                  children: <Widget>[
                    // NAME
                    SizedBox(
                      width: 190,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          onSurface: Colors.white,
                          shadowColor: Color.fromARGB(0, 255, 255, 255),
                          side: BorderSide(
                            color: Colors.lightBlueAccent,
                            width: 3,
                          ),
                        ),
                        onPressed: null,
                        // This child will be changed with user's name
                        child: Text(
                          "${user?.displayName}",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        /////////////////////////////////////////////
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20)),
                    // E-MAIL
                    SizedBox(
                      width: 190,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          onSurface: Colors.white,
                          shadowColor: Color.fromARGB(0, 255, 255, 255),
                          side: BorderSide(
                            color: Colors.lightBlueAccent,
                            width: 3,
                          ),
                        ),
                        onPressed: null,
                        // This child will be changed with user's surname
                        child: Text(
                          "${user?.email}",
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
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _signOut();
          },
          child: const Icon(Icons.logout),
          backgroundColor: Colors.lightBlueAccent,
        ),
      ),
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainMenuPage()),
        );
        return true;
      },
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile Photo",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton.icon(
                onPressed: () {
                  // TAKE A SHOT WITH A CAMERA
                },
                icon: Icon(Icons.camera),
                label: Text("Camera"),
              ),
              FlatButton.icon(
                onPressed: () {
                  // TAKE IMAGE FROM GALLERY
                },
                icon: Icon(Icons.image),
                label: Text("Gallery"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

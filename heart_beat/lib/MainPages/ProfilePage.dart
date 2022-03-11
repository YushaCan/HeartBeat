import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  ProfilePage({Key? key}) : super(key: key);

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
  // For the pick Profile Image
  File? _pickedImage;
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
                padding: EdgeInsets.only(left: 20),
              ),
              // PROFILE PHOTO AND NICK
              Stack(
                children: <Widget>[
                  Container(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.purple,
                      child: CircleAvatar(
                        radius: 55,
                        backgroundImage: _pickedImage == null
                            ? AssetImage("assets/profilephoto.jpg")
                                as ImageProvider
                            : FileImage(_pickedImage!),
                      ),
                    ),
                  ),
                  /*SizedBox(
                    width: 100,
                    height: 100,
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/profilephoto.jpg"),
                    ),
                  ),*/
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
                        radius: 15,
                        backgroundColor: Color.fromARGB(0, 255, 255, 255),
                        child: Icon(
                          Icons.camera_alt,
                          size: 35,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                  ),
                  // LEVEL CIRCLE
                  Padding(
                    padding: EdgeInsets.only(
                      left: 87,
                    ),
                    child: CircleAvatar(
                      radius: 17,
                      backgroundColor: Colors.blue,
                      child: Text(
                        "$level",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
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

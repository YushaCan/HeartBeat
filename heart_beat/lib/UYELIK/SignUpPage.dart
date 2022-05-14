import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat/MainPages/MainMenu.dart';
import '../XP/actions.dart';
import 'LoginPage.dart';

class ULEVEL{
  final  level;
  ULEVEL(this.level);

  ULEVEL.fromJson(Map<dynamic, dynamic> json) : level = json['level'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'level': level,
  };
}

class UWATER{
  final  water;
  UWATER(this.water);

  UWATER.fromJson(Map<dynamic, dynamic> json) : water = json['water'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'water': water,
  };
}

class UDATA{
  final  uid;
  final name;
  final photoURL;
  UDATA(this.uid,this.name,this.photoURL);

  UDATA.fromJson(Map<dynamic, dynamic> json) :
        uid = json['uid'] as String,
        name = json['name'] as String,
        photoURL = json['photoURL'] as String
        ;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'uid': uid,
    'name': name,
    'photoURL': photoURL,
  };
}

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      home: Scaffold(
        //appBar: AppBar(),
        body: SignUp(),
      ),
    );
  }
}

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool seePassword = true;
  bool confirmedPassword = false;
  bool submit = false;
  bool lockIcon = true;

  String passwordText = "";
  String confirmedPasswordText = "";
  String email = "";
  String DisplayName = "";

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  void Toggle() {
    setState(() {
      seePassword = !seePassword;
    });
  }

  Future<void> _createUser(String DisplayName) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.trim(), password: passwordText);
      User? user = userCredential.user;
      if (user != null) {
        //add display name for just created user
        user.updateDisplayName(DisplayName);
        //get updated user
        await user.reload();
        var _auth = FirebaseAuth.instance;
        user = await _auth.currentUser;
        //print final version to console
        print("Registered user:");
        print(user);
      }
      //***********SET XP NODE FOR THE NEW USER***********
      final user_xp = UXP("0");
      DatabaseReference ref1 = FirebaseDatabase.instance.ref()
          .child("USERS")
          .child("${userCredential.user?.uid}")
          .child("XP");
      ref1.push().set(user_xp.toJson());

      //***********SET LEVEL NODE FOR THE NEW USER***********
      final user_level = ULEVEL("0");
      DatabaseReference ref2 = FirebaseDatabase.instance.ref()
          .child("USERS")
          .child("${userCredential.user?.uid}")
          .child("LEVEL");
      ref2.push().set(user_level.toJson());

      //***********SET USERS_TO_VIEW NODE FOR THE NEW USER***********
      final user_data = UDATA(user?.uid,user?.displayName,user?.photoURL);
      DatabaseReference ref3 = FirebaseDatabase.instance.ref().child("USERS_TO_VIEW");
      ref3.push().set(user_data.toJson());

      //***********SET WATER NODE FOR THE NEW USER***********
      final user_water = UWATER("0");
      DatabaseReference ref4 = FirebaseDatabase.instance.ref()
          .child("USERS")
          .child("${userCredential.user?.uid}")
          .child("WATER");
      ref4.push().set(user_water.toJson());

      DatabaseReference ref5 = FirebaseDatabase.instance.ref()
          .child("USERS").child("${userCredential.user?.uid}").child("EXERCISES");
      ref5.child("CARDIO").child("ONE").push().set({"isDone":"0", "set": "3","exNo":1});
      ref5.child("CARDIO").child("TWO").push().set({"isDone":"0", "set": "3","exNo":2});
      ref5.child("CARDIO").child("THREE").push().set({"isDone":"0", "set": "3","exNo":3});
      ref5.child("CARDIO").child("FOUR").push().set({"isDone":"0", "set": "3","exNo":4});

      ref5.child("CORE").child("ONE").push().set({"isDone":"0", "set": "1","exNo":1});
      ref5.child("CORE").child("TWO").push().set({"isDone":"0", "set": "1","exNo":2});

      ref5.child("LEGS").child("ONE").push().set({"isDone":"0", "set": "2","exNo":1});
      ref5.child("LEGS").child("TWO").push().set({"isDone":"0", "set": "2","exNo":2});
      ref5.child("LEGS").child("THREE").push().set({"isDone":"0", "set": "2","exNo":3});
      ref5.child("LEGS").child("FOUR").push().set({"isDone":"0", "set": "2","exNo":4});

    } on FirebaseAuthException catch (e) {
      print("error: $e");
    } catch (e) {
      print("error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: <
          Widget>[
        // This row is for justify the upper space of the Heart Beat
        Row(children: <Widget>[
          const Text(
            '',
            style: TextStyle(
              fontSize: 100,
            ),
          ),
        ]),
        Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Heart',
                style: TextStyle(
                  color: Color.fromARGB(255, 199, 20, 8),
                  fontWeight: FontWeight.bold,
                  fontSize: 45,
                ),
              ),
              const Text(
                ' Beat',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 45,
                ),
              )
            ]),
        Row(children: <Widget>[
          const Text(
            '',
            style: TextStyle(
              fontSize: 25,
            ),
          ),
        ]),
         Padding(
          padding: EdgeInsets.symmetric(horizontal: 45, vertical: 8),
          child: TextFormField(
            controller: nameController,
            onChanged: (value) {
              DisplayName = nameController.text;
            },
            decoration: InputDecoration(
              //icon: Icon(Icons.email),
              border: OutlineInputBorder(),
              hintText: 'Username',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 45, vertical: 8),
          child: TextFormField(
            onChanged: (value) {
              email = value;
            },
            decoration: InputDecoration(
              //icon: Icon(Icons.email),
              border: OutlineInputBorder(),
              hintText: 'E-Mail',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 45, vertical: 8),
          child: TextFormField(
            obscureText: seePassword,
            controller: passwordController,
            onChanged: (value) {
              passwordText = passwordController.text;
            },
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  Toggle();
                  lockIcon = !lockIcon;
                },
                icon: lockIcon ? Icon(Icons.lock) : Icon(Icons.lock_open),
              ),
              border: OutlineInputBorder(),
              hintText: 'Password',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 45, vertical: 8),
          child: TextFormField(
            obscureText: true,
            controller: confirmPasswordController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: (value) {
              confirmedPasswordText = confirmPasswordController.text;
              if (passwordText != confirmedPasswordText) {
                print("Passwords DOESN'T MATCH!");
                setState(() {
                  confirmedPassword = false;
                });
              } else {
                print("Password is Correct!");
                setState(() {
                  confirmedPassword = true;
                });
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This can not be empty';
              } else if (value != null && confirmedPassword) {
                return null;
              } else if (value != null && !confirmedPassword) {
                return 'Passwords does not match!';
              }
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Confirm Password',
            ),
          ),
        ),
        // Sign Up Button
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: confirmedPassword
                        ? Color.fromARGB(255, 5, 115, 218)
                        : Colors.grey,
                    padding: EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                    textStyle: TextStyle(
                      fontSize: 20,
                    )),
                child: Text('Sign Up'),
                onPressed: () {
                  // When tapped, if everything is right, passed to the Main Menu Page. It needs an animation between two pages.
                  _createUser(DisplayName);
                  if (confirmedPassword) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserDataList()),
                    );
                  }
                })),
      ]),
    );
  }
}

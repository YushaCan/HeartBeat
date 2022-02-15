import 'package:flutter/material.dart';
import 'package:heart_beat/MainMenu.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      home: Scaffold(
        appBar: AppBar(),
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
  bool lockIcon = true;
  String passwordText = "";
  String confirmedPasswordText = "";
  void Toggle() {
    setState(() {
      seePassword = !seePassword;
    });
  }

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: <
        Widget>[
      // This row is for justify the upper space of the Heart Beat
      Row(children: <Widget>[
        const Text(
          '',
          style: TextStyle(
            fontSize: 30,
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
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 45, vertical: 8),
        child: TextField(
          decoration: InputDecoration(
            //icon: Icon(Icons.person),
            border: OutlineInputBorder(),
            hintText: 'Username',
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 45, vertical: 8),
        child: TextFormField(
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
          onEditingComplete: () {
            passwordText = passwordController.text;
          },
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () {
                Toggle();
                lockIcon = !lockIcon;
                // TO CONTROL PASSWORD WITH CONFIRMED PASSWORD
                // passwordText = passwordController.text;
                //confirmedPasswordText = confirmPasswordController.text;
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
          onEditingComplete: () {
            confirmedPasswordText = confirmPasswordController.text;
            if (passwordText != confirmedPasswordText) {
              //print("Passwords DOESN'T MATCH!");
            } else {
              //print("Password is Correct!");
            }
          },
          validator: (value) {
            if (passwordText != confirmedPasswordText) {
              return 'Passwords does not match';
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
            //icon: Icon(Icons.lock),
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
                  primary: Color.fromARGB(255, 5, 115, 218),
                  padding: EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                  textStyle: TextStyle(
                    fontSize: 20,
                  )),
              child: Text('Sign Up'),
              onPressed: () {
                // When tapped, if everything is right, passed to the Main Menu Page. It needs an animation between two pages.
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainMenuPage()),
                );
              })),
    ]);
  }
}

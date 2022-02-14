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
        body: const SignUp(),
      ),
    );
  }
}

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(children: <Widget>[
            const Text(
              '',
              style: TextStyle(
                fontSize: 50,
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
                    fontSize: 50,
                  ),
                ),
                const Text(
                  ' Beat',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
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
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
            child: TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.person),
                border: OutlineInputBorder(),
                hintText: 'Username',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
            child: TextFormField(
              decoration: InputDecoration(
                icon: Icon(Icons.email),
                border: OutlineInputBorder(),
                hintText: 'E-Mail',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
            child: TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                icon: Icon(Icons.password),
                border: OutlineInputBorder(),
                hintText: 'Password',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
            child: TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                icon: Icon(Icons.password),
                border: OutlineInputBorder(),
                hintText: 'Confirm Password',
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 32),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 5, 115, 218),
                      padding:
                          EdgeInsets.symmetric(horizontal: 75, vertical: 20),
                      textStyle: TextStyle()),
                  child: Text('Sign Up'),
                  onPressed: () {
                    // When tapped, passed to the Main Menu Page. It needs an animation between two pages.
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainMenuPage()),
                    );
                  })),
        ]);
  }
}

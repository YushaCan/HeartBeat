import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat/Antreman2/ExerciseCounter/Counter.dart';
import 'package:heart_beat/MainPages/MainMenu.dart';
import 'package:heart_beat/Antreman2/Pages/ExerciseHomePage.dart';
import 'package:heart_beat/Antreman2/Pages/testPage.dart';
import 'package:heart_beat/Antreman2/firebasedata/exerciseSetdata.dart';
import 'package:heart_beat/Antreman2/models/exercise.dart';
import 'package:heart_beat/Antreman2/firebasedata/realtimedata.dart';
import 'package:heart_beat/Antreman2/models/testData.dart';
import 'package:heart_beat/StepCounter/test2.dart';
import 'package:heart_beat/UYELIK/SignUpPage.dart';
import 'package:heart_beat/MainPages/SplashScreen.dart';
import 'package:heart_beat/UYELIK/LoginPage.dart';
import '../FriendShip/FriendShipActions.dart';
import '../FriendShip/GetUsersFireBase.dart';
import 'MainMenu.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreenState(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Exercise exercise = new Exercise(
      name: 'qqq', duration: "1500", noOfReps: "3", videoUrl: 'qqq');
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserDataList()),
                );
              },
              child: Text("SignInPage"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ExerciseHomePage()),
                );
              },
              child: Text("MySteppage"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              child: Text("Sign Up Page"),
            ),
            TextButton(
              onPressed: () {
                FriendShipSentRequests();
              },
              child: Text("Users"),
            ),
            TextButton(
              onPressed: () {
                String uid = "GpsvIg2UJJZcV2g1SApCiWQ1WuE2";
                //AddFriend(uid);
                RejectRequest(uid);
              },
              child: Text("cancel friend"),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainMenuPage()),
          );
          // ExercisesCount();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

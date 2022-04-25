import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat/MainPages/main.dart';

import 'MainMenu.dart';

class SplashScreenState extends StatefulWidget {
  const SplashScreenState({Key? key}) : super(key: key);

  @override
  State<SplashScreenState> createState() => _SplashScreenStateState();
}

class _SplashScreenStateState extends State<SplashScreenState> {
   @override
  void initState(){
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 5000), (){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainMenuPage()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.network(
          "https://firebasestorage.googleapis.com/v0/b/heartbeat-cbae0.appspot.com/o/splash%2FNatural%20Vegetables%20by%20Petter%20Pentil%C3%A4.gif?alt=media&token=f4915876-857c-4ceb-a5e0-f224bd142988",
          height: 200,
          width: 350,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

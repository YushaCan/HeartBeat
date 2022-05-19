import 'dart:math';
import 'package:another_flushbar/flushbar.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat/XP/actions.dart';
import '../../MainPages/MainMenu.dart';
import '../models/exercise.dart';


class CongratulationsWidget extends StatefulWidget {
  const CongratulationsWidget({Key? key, required this.exercises}) : super(key: key);
  final Exercise exercises;
  @override
  _CongratulationsWidgetState createState() => _CongratulationsWidgetState();

}

class _CongratulationsWidgetState extends State<CongratulationsWidget> {
  late ConfettiController controllerTopCenter;
  @override
  void initState() {
    // TODO: implement initState
    if(mounted){
      setState(() {
        initController();
        super.initState();
        EarnXp(10);
      });
    }
  }

  void initController() {
    controllerTopCenter =
        ConfettiController(duration: const Duration(seconds: 1));
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async{
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainMenuPage()),
          );
          return true;
        },
      child:Scaffold(
        backgroundColor: Colors.pink[50],
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              buildConfettiWidget(controllerTopCenter, pi / 1),
              buildConfettiWidget(controllerTopCenter, pi / 4),
              Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      "assets/trophy.png",
                      width: MediaQuery.of(context).size.width*0.5,
                      height: MediaQuery.of(context).size.height*0.5,
                    ),
                  ],
                ),
              ),
              buildButton(),
            ],
          ),
        ),
      ),
    );
  }

  Align buildButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100),
        child: RaisedButton(
          onPressed: (){
            controllerTopCenter.play();
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: Colors.red,
          textColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Congratulations! You earned 10 xp!",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Align buildConfettiWidget(controller, double blastDirection) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConfettiWidget(
        maximumSize: Size(30, 30),
        shouldLoop: false,
        confettiController: controller,
        blastDirection: blastDirection,
        blastDirectionality: BlastDirectionality.directional,
        maxBlastForce: 20, // set a lower max blast force
        minBlastForce: 8, // set a lower min blast force
        emissionFrequency: 1,
        numberOfParticles: 16, // a lot of particles at once
        gravity: 1,
      ),
    );
  }


}
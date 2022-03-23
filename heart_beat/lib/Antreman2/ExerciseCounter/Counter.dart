import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ButtonWidget.dart';
import 'CongratulationsWidget.dart';

class CounterWidget extends StatefulWidget {
  const CounterWidget({Key? key}) : super(key: key);

  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  static const maxSeconds = 10;
  int seconds = maxSeconds;
  Timer? timer;
  void startTimer({bool reset = true}){
    if(reset){
      resetTimer();
    }
    timer = Timer.periodic(Duration(seconds: 1), (_){
      if(seconds>0){
        setState(() {
          seconds--;
        });
      } else {
        stopTimer(reset: false);
      }
    });
  }
  void resetTimer() => seconds = maxSeconds;

  void stopTimer({bool reset = true}){
    if(reset){
      resetTimer();
    }
    setState(() {
      timer?.cancel();
    });
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildTimer(),
              const SizedBox(height: 80,),
              buildButtons(),
            ],
          ),
        ),
    );
  }

  Widget buildTimer()=> SizedBox(
    width: 100,
    height: 100,
    child: Stack(
      fit: StackFit.expand,
      children: [
        CircularProgressIndicator(
          value: 1 - seconds / maxSeconds,
          valueColor: AlwaysStoppedAnimation(Colors.white),
          strokeWidth: 12,
          backgroundColor: Colors.greenAccent,
        ),
        Center(
          child: buildTime(),
        )
      ],
    ),
  );

  Widget buildButtons(){
    final isRunning = timer == null ? false: timer!.isActive;
    final isCompleted = seconds == maxSeconds || seconds == 0;

    return isRunning || !isCompleted
      ? Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ButtonWidget(
          text: isRunning ? 'Pause' : 'Resume',
          onClicked: (){
            if(isRunning){
              stopTimer(reset: false);
            }else{
              startTimer(reset: false);
            }
          },
        ),
        ButtonWidget(
          text: 'Cancel',
          onClicked: (){
            print("I am clicked");
            stopTimer();
          },
        )
      ],
    ) : ButtonWidget(
      text: 'Start',
      color: Colors.black,
      backgroundColor: Colors.white,
      onClicked:(){
        print("I am clicked");
        startTimer(reset: false);
      },
    );
  }

  Widget buildTime(){
    if(seconds == 0){
      //return Icon(Icons.done, color: Colors.greenAccent, size: 50,);
      return CongratulationsWidget();
    }else{
      return Text(
        '$seconds',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.green,
          fontSize: 30,
        ),
      );
    }
  }
}

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../FriendShip/FriendShipActions.dart';
import '../../FriendShip/GetUsersFireBase.dart';
import '../models/exercise.dart';
import 'ButtonWidget.dart';
import 'CongratulationsWidget.dart';
import 'package:firebase_database/firebase_database.dart';

void markAsDone(Exercise ex) async{
  String set = "";
  if(int.parse(ex.set!)==1){
    set="CORE";
  }
  else if(int.parse(ex.set!)==2){
    set="LEGS";
  }
  else if(int.parse(ex.set!)==3){
    set = "CARDIO";
  }
  String exNo="";
  if(int.parse(ex.exNo!)==1){
    exNo = "ONE";
  }
  else if(int.parse(ex.exNo!)==2){
    exNo = "TWO";
  }
  else if(int.parse(ex.exNo!)==3){
    exNo = "THREE";
  }
  else if(int.parse(ex.exNo!)==4){
    exNo = "FOUR";
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  String childToDelete = "";
  DatabaseReference ref = FirebaseDatabase.instance.ref("USERS/${user?.uid}/EXERCISES/${set}/${exNo}/");
  await ref.once().then((value){
    value.snapshot.children.forEach((element) {
      childToDelete = element.key.toString();
      FirebaseDatabase.instance.ref("USERS/${user?.uid}/EXERCISES/${set}/${exNo}/${childToDelete}").update({
        'exNo': ex.exNo,
        'set':ex.set,
        'isDone': '1'});
    });
  });

}

void MarkAsNotDone() async{
  // 1:1 2 2:1 2 3 4 3: 1 2 3 4
  List<Userz> users= await showUSERS_LIST();
  String childToDelete = "";
  for(int i=0; i<users.length; i++ ){

    // CORE ONE
    DatabaseReference ref = FirebaseDatabase.instance.ref("USERS/${users[i].uid}/EXERCISES/CORE/ONE");
    await ref.once().then((value){
      value.snapshot.children.forEach((element) {
        childToDelete = element.key.toString();
        FirebaseDatabase.instance.ref("USERS/${users[i].uid}/EXERCISES/CORE/ONE/${childToDelete}").update({
          'exNo': 1,
          'set':1,
          'isDone': '0'});
      });
    });
    // CORE TWO
    DatabaseReference ref1 = FirebaseDatabase.instance.ref("USERS/${users[i].uid}/EXERCISES/CORE/TWO");
    await ref1.once().then((value){
      value.snapshot.children.forEach((element) {
        childToDelete = element.key.toString();
        FirebaseDatabase.instance.ref("USERS/${users[i].uid}/EXERCISES/CORE/TWO/${childToDelete}").update({
          'exNo': 2,
          'set':1,
          'isDone': '0'});
      });
    });

    // LEGS ONE
    DatabaseReference ref2 = FirebaseDatabase.instance.ref("USERS/${users[i].uid}/EXERCISES/LEGS/ONE");
    await ref2.once().then((value){
      value.snapshot.children.forEach((element) {
        childToDelete = element.key.toString();
        FirebaseDatabase.instance.ref("USERS/${users[i].uid}/EXERCISES/LEGS/ONE/${childToDelete}").update({
          'exNo': 1,
          'set':2,
          'isDone': '0'});
      });
    });

    // LEGS TWO
    DatabaseReference ref3 = FirebaseDatabase.instance.ref("USERS/${users[i].uid}/EXERCISES/LEGS/TWO");
    await ref3.once().then((value){
      value.snapshot.children.forEach((element) {
        childToDelete = element.key.toString();
        FirebaseDatabase.instance.ref("USERS/${users[i].uid}/EXERCISES/LEGS/TWO/${childToDelete}").update({
          'exNo': 2,
          'set':2,
          'isDone': '0'});
      });
    });

    // LEGS THREE
    DatabaseReference ref4 = FirebaseDatabase.instance.ref("USERS/${users[i].uid}/EXERCISES/LEGS/THREE");
    await ref4.once().then((value){
      value.snapshot.children.forEach((element) {
        childToDelete = element.key.toString();
        FirebaseDatabase.instance.ref("USERS/${users[i].uid}/EXERCISES/LEGS/THREE/${childToDelete}").update({
          'exNo': 3,
          'set':2,
          'isDone': '0'});
      });
    });

    // LEGS FOUR
    DatabaseReference ref5 = FirebaseDatabase.instance.ref("USERS/${users[i].uid}/EXERCISES/LEGS/FOUR");
    await ref5.once().then((value){
      value.snapshot.children.forEach((element) {
        childToDelete = element.key.toString();
        FirebaseDatabase.instance.ref("USERS/${users[i].uid}/EXERCISES/LEGS/FOUR/${childToDelete}").update({
          'exNo': 4,
          'set':2,
          'isDone': '0'});
      });
    });

    // CARDIO ONE
    DatabaseReference ref6 = FirebaseDatabase.instance.ref("USERS/${users[i].uid}/EXERCISES/CARDIO/ONE");
    await ref6.once().then((value){
      value.snapshot.children.forEach((element) {
        childToDelete = element.key.toString();
        FirebaseDatabase.instance.ref("USERS/${users[i].uid}/EXERCISES/CARDIO/ONE/${childToDelete}").update({
          'exNo': 1,
          'set':3,
          'isDone': '0'});
      });
    });

    // CARDIO TWO
    DatabaseReference ref7 = FirebaseDatabase.instance.ref("USERS/${users[i].uid}/EXERCISES/CARDIO/TWO");
    await ref7.once().then((value){
      value.snapshot.children.forEach((element) {
        childToDelete = element.key.toString();
        FirebaseDatabase.instance.ref("USERS/${users[i].uid}/EXERCISES/CARDIO/TWO/${childToDelete}").update({
          'exNo': 2,
          'set':3,
          'isDone': '0'});
      });
    });

    // CARDIO THREE
    DatabaseReference ref8 = FirebaseDatabase.instance.ref("USERS/${users[i].uid}/EXERCISES/CARDIO/THREE");
    await ref8.once().then((value){
      value.snapshot.children.forEach((element) {
        childToDelete = element.key.toString();
        FirebaseDatabase.instance.ref("USERS/${users[i].uid}/EXERCISES/CARDIO/THREE/${childToDelete}").update({
          'exNo': 3,
          'set':3,
          'isDone': '0'});
      });
    });

    // CARDIO FOUR
    DatabaseReference ref9 = FirebaseDatabase.instance.ref("USERS/${users[i].uid}/EXERCISES/CARDIO/FOUR");
    await ref9.once().then((value){
      value.snapshot.children.forEach((element) {
        childToDelete = element.key.toString();
        FirebaseDatabase.instance.ref("USERS/${users[i].uid}/EXERCISES/CARDIO/FOUR/${childToDelete}").update({
          'exNo': 4,
          'set':3,
          'isDone': '0'});
      });
    });

    FirebaseDatabase.instance.ref("USERS/${users[i].uid}/WATER").update({
      'water': '0'});
  }
}
class CounterWidget extends StatefulWidget {
  const CounterWidget({Key? key, required this.exercises}) : super(key: key);
  final Exercise exercises;
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  late int seconds;
  late int maxSeconds;
  @override
  void initState() {
    if(mounted){
      maxSeconds = int.parse(widget.exercises.duration!);
      seconds = maxSeconds;
      super.initState();
    }
  }
  Timer? timer;
  void startTimer({bool reset = true}){
    if(reset){
      resetTimer();
    }
    timer = Timer.periodic(Duration(seconds: 1), (_){
      if(seconds>0){
        if(mounted){
          setState(() {
            seconds--;
          });
        }
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
    if(mounted){
    setState(() {
        timer?.cancel();
    });}
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildTimer(),
              const SizedBox(height: 20,),
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
          backgroundColor: Colors.greenAccent,
          onClicked: (){
            if(isRunning){
              stopTimer(reset: false);
            }else{
              startTimer(reset: false);
            }
          },
        ),
        SizedBox(
          width: 10,
        ),
        ButtonWidget(
          text: 'Cancel',
          backgroundColor: Colors.greenAccent,
          onClicked: (){
            print("I am clicked");
            stopTimer();
          },
        )
      ],
    ) : ButtonWidget(
      text: 'Start',
      color: Colors.greenAccent,
      backgroundColor: Colors.white,
      onClicked:(){
        startTimer(reset: false);
      },
    );
  }

  Widget buildTime(){
    if(seconds == 0){
      markAsDone(widget.exercises);
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => CongratulationsWidget(exercises: widget.exercises,)));
      });
      return Container();
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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class UXP{
  late final  xp;
  UXP(this.xp);

  UXP.fromJson(Map<dynamic, dynamic> json) : xp = json['xp'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'xp': xp,
  };

  Map<String, Object?> toUpdate() => <String, Object?>{
    'xp': xp,
  };
}

void EarnXp(int xp) async{
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  final current_uid = user?.uid;
  int? previous_xp = 0;

  //**********************Retrieve exisiting xp**********************
  DatabaseReference ref = FirebaseDatabase.instance.ref("USERS/$current_uid/XP");
  await ref.once().then((value){
    value.snapshot.children.forEach((element) {
      previous_xp = element.value as int?;
      print(previous_xp);
    });
  });

  //**********************SentRequests*******************************
  xp += previous_xp!;
  FirebaseDatabase.instance.ref()
      .child("USERS")
      .child("$current_uid")
      .child("XP")
      .set({"count": xp});
}

Future<int?> showXP() async{
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  final current_uid = user?.uid;
  late int? xp;
  DatabaseReference ref = FirebaseDatabase.instance.ref("USERS/$current_uid/XP");
  await ref.once().then((value){
    value.snapshot.children.forEach((element) {
      xp = element.value as int?;
    });
  });
  return xp;
}

void AddWater(int water) async{
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  final current_uid = user?.uid;
  int? previous_water = 0;

  //**********************Retrieve exisiting water**********************
  DatabaseReference ref = FirebaseDatabase.instance.ref("USERS/$current_uid/WATER");
  await ref.once().then((value){
    value.snapshot.children.forEach((element) {
      previous_water = element.value as int?;
      print(previous_water);
    });
  });

  //**********************SentRequests*******************************
  water += previous_water!;
  FirebaseDatabase.instance.ref()
      .child("USERS")
      .child("$current_uid")
      .child("WATER")
      .set({"water": water});
}

Future<int?> showWater() async{
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  final current_uid = user?.uid;
  late int? water;

  DatabaseReference ref = FirebaseDatabase.instance.ref("USERS/$current_uid/WATER");
  await ref.once().then((value){
    value.snapshot.children.forEach((element) {
      water = element.value as int?;
    });
  });

  return water;
}

void AddLevel(int level) async{
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  final current_uid = user?.uid;
  int? previous_level = 0;

  //**********************Retrieve exisiting xp**********************
  DatabaseReference ref = FirebaseDatabase.instance.ref("USERS/$current_uid/LEVEL");
  await ref.once().then((value){
    value.snapshot.children.forEach((element) {
      previous_level = element.value as int?;
      print(previous_level);
    });
  });

  //**********************SentRequests*******************************
  level += previous_level!;
  FirebaseDatabase.instance.ref()
      .child("USERS")
      .child("$current_uid")
      .child("LEVEL")
      .set({"count": level});
}

Future<int?> showLevel()async{
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  final current_uid = user?.uid;
  late int? level;

  DatabaseReference ref = FirebaseDatabase.instance.ref("USERS/$current_uid/LEVEL");
  await ref.once().then((value){
    value.snapshot.children.forEach((element) {
      level = element.value as int?;
    });
  });

  return level;
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class UXP {
  late final xp;
  UXP(this.xp);

  UXP.fromJson(Map<dynamic, dynamic> json) : xp = json['xp'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'count': xp,
      };

  Map<String, Object?> toUpdate() => <String, Object?>{
        'count': xp,
      };
}

void EarnXp(int xp) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  final current_uid = user?.uid;
  int? previous_xp = 0;

  //**********************Retrieve exisiting xp**********************
  DatabaseReference ref =
      FirebaseDatabase.instance.ref("USERS/$current_uid/XP");
  await ref.once().then((value) {
    value.snapshot.children.forEach((element) {
      previous_xp = int.parse(element.value.toString());

    });
  });

  print("earn xp is called");
  //**********************SentRequests*******************************
  xp = xp+previous_xp!;
  print(xp);
  FirebaseDatabase.instance
      .ref()
      .child("USERS")
      .child("$current_uid")
      .child("XP")
      .set({"count": xp});
}

void XpSifirla() async {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  final current_uid = user?.uid;

  FirebaseDatabase.instance
      .ref()
      .child("USERS")
      .child("$current_uid")
      .child("XP")
      .set({"count": "0"});
}

Future<int?> showXP() async {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  final current_uid = user?.uid;
  late int? xp;
  DatabaseReference ref =
      FirebaseDatabase.instance.ref("USERS/$current_uid/XP");
  await ref.once().then((value) {
    value.snapshot.children.forEach((element) {
      xp = int.parse(element.value.toString());
    });
  });
  return xp;
}

void AddWater(double water) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  final current_uid = user?.uid;
  double? previous_water = 0.0;

  //**********************Retrieve exisiting water**********************
  DatabaseReference ref =
      FirebaseDatabase.instance.ref("USERS/$current_uid/WATER");
  await ref.once().then((value) {
    value.snapshot.children.forEach((element) {
      previous_water = double.parse(element.value.toString());
      print(previous_water);
    });
  });

  //**********************SentRequests*******************************
  water += previous_water!;
  FirebaseDatabase.instance
      .ref()
      .child("USERS")
      .child("$current_uid")
      .child("WATER")
      .set({"water": water});
}

Future<double?> showWater() async {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  final current_uid = user?.uid;
  late double? water;

  DatabaseReference ref =
      FirebaseDatabase.instance.ref("USERS/$current_uid/WATER");
  await ref.once().then((value) {
    value.snapshot.children.forEach((element) {
      water = double.parse(element.value.toString());
    });
  });

  return water;
}

void AddLevel(int level) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  final current_uid = user?.uid;
  int? previous_level = 0;

  //**********************Retrieve exisiting xp**********************
  DatabaseReference ref =
      FirebaseDatabase.instance.ref("USERS/$current_uid/LEVEL");
  await ref.once().then((value) {
    value.snapshot.children.forEach((element) {
      previous_level = int.parse(element.value.toString());
      print(previous_level);
    });
  });

  //**********************SentRequests*******************************
  level += previous_level!;
  FirebaseDatabase.instance
      .ref()
      .child("USERS")
      .child("$current_uid")
      .child("LEVEL")
      .set({"count": level});
}

Future<int?> showLevel() async {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  final current_uid = user?.uid;
  int level = 0;

  DatabaseReference ref =
      FirebaseDatabase.instance.ref("USERS/$current_uid/LEVEL");
  await ref.once().then((value) {
    value.snapshot.children.forEach((element) {
      level = int.parse(element.value.toString());
    });
  });

  return level;
}

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
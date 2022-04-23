import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat/Challenge/challengeWidget.dart';

import '../FriendShip/FriendShipActions.dart';
import 'ChallengeFirebaseData.dart';

class friends extends StatefulWidget {
  const friends({Key? key}) : super(key: key);

  @override
  _friendsState createState() => _friendsState();
}

class _friendsState extends State<friends> {
  int selectedIndex = -1;
  String selectedUserId = "";
  List<UID> friendsSet = [];


  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    friendsSet = await showFriendsSetData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.indigo[900],
      appBar: AppBar(
        title: Text(
            "Friends To Challenge "
        ),
        backgroundColor: Colors.indigo[900],
      ),
      body: Container(
        width: 200,
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.symmetric(vertical: 20),
            itemCount: friendsSet.length,
            itemBuilder: (context, index){
              return InkWell(
                onTap: () {
                  setState((){
                    selectedIndex =index;
                    selectedUserId = friendsSet[index].USER_ID;
                  });
                } ,
                child: Card(
                  shadowColor: (selectedIndex==index)? Colors.green: null,
                  shape: (selectedIndex==index)
                      ? RoundedRectangleBorder(
                      side: BorderSide(color: Colors.green))
                      : null,
                  child: Text("${friendsSet[index].USER_ID}"),
                ), //Card
                //SizedBox
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => challenges(selectedUserId: selectedUserId,)),
          );
      },
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}

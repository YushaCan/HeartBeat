import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'FriendShipActions.dart';

class FriendRequestsWidget extends StatefulWidget {
  const FriendRequestsWidget({Key? key}) : super(key: key);

  @override
  _FriendRequestsWidgetState createState() => _FriendRequestsWidgetState();
}

class _FriendRequestsWidgetState extends State<FriendRequestsWidget> {

  List<Userz> friendsSet = [];

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    friendsSet = await showFriendRequestsSetData();
    super.setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text("Firends List"),
        titleTextStyle: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Column(
        children: <Widget>[
          // LIST PART
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: friendsSet.length,
            itemBuilder: (BuildContext context, int index) {
              // EVERY ELEMENT OF THE LIST
              return InkWell(
                onTap: () {},
                //color: Colors.white,
                child: Card(
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        // THIS PROFILE PICTURE WILL BE PULL FROM THE DB
                        backgroundImage: AssetImage("assets/profilephoto.jpg"),
                      ),
                      Padding(padding: EdgeInsets.only(top: 40, left: 7)),
                      // User Names
                      Text("${friendsSet[index].uname}"), // Usernames
                      Spacer(),
                      IconButton(
                          onPressed: (){
                            AcceptFriend(friendsSet[index].uid!);
                          },
                          icon: const Icon(Icons.done),
                          color: Colors.green,
                      ),
                      IconButton(
                          onPressed: (){
                            RejectCancelRequest(friendsSet[index].uid!);
                          },
                          icon: const Icon(Icons.close),
                          color: Colors.red,)
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:heart_beat/MainPages/AddFriendsPage.dart';

import '../Challenge/ChallengeFirebaseData.dart';
import '../Challenge/challengeWidget.dart';
import '../FriendShip/FriendShipActions.dart';

class SideBar extends StatefulWidget {
  SideBar({Key? key}) : super(key: key);

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  int selectedIndex = -1;

  /////////////////////////////////
  late double paddingFromLeft = 25;

  late double paddingFromBottom = 10;

  // Increase or Decrease when new user logged in or logged out
  late int online = 0;

  late int totalFriends = 0;

  /////////////////////////////////////////////////////////////
  // This is a friends list which pulled from the database
  late List<String> friendsList = <String>[];

  late List<bool> isOnline = <bool>[
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  // Bu iki fonksiyon online olan kişileri ve toplam arkadaş listesindeki kişi sayısını güncellemeyi sağlıyor.
  int TotalCount() {
    totalFriends = friendsSet.length;
    return totalFriends;
  }

  int OnlineCount() {
    online = 0;
    for (int i = 0; i < isOnline.length; i++) {
      if (isOnline[i] == true) {
        online++;
      }
    }
    return online;
  }

  List<Userz> friendsSet = [];

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    friendsSet = await showFriendsSetData();
    super.setState(() {});
  }
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(171, 64, 195, 255),
      child: Column(
        children: <Widget>[
          // COULD PLACED SIMPLE ACCOUNT INFORMATION LIKE PHOTOS AND MAIL ETC.

          // FOR A GAP FROM THE TOP OF THE SCREEN
          Padding(
            padding: EdgeInsets.only(top: 100),
          ),

          ListTile(
            title: Text(
              // Replace with real time online persons.
              "Friends (" +
                  OnlineCount().toString() +
                  "/" +
                  TotalCount().toString() +
                  ")",
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: friendsSet.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    setState(() => selectedIndex = index);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => challenges(
                            selectedUserData: friendsSet[selectedIndex],
                          ),
                        ));
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      left: paddingFromLeft,
                      bottom: paddingFromBottom,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          // Will change with friends list's name
                          "${friendsSet[index].uname}",
                          style: TextStyle(
                            fontSize: 20,
                            // Dynamically change color. Based on user is online or not
                            color: isOnline[index] ? Colors.white : Colors.grey,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Icon(
                          Icons.circle,
                          color: isOnline[index] ? Colors.green : Colors.grey,
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: 25,
              left: 200,
            ),
            // TO ADD FRIEND PAGE
            child: IconButton(
              icon: Icon(Icons.person_add),
              iconSize: 60,
              color: Colors.white,
              onPressed: () {
                print('ADD FRIEND PAGE OPENED');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddFriends()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

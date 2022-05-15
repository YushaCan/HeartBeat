import 'package:flutter/material.dart';
import 'package:heart_beat/FriendShip/FriendShipActions.dart';
import 'package:heart_beat/MainPages/AddFriendsPage.dart';

class SideBar extends StatefulWidget {
  SideBar({Key? key}) : super(key: key);

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  /////////////////////////////////
  late double paddingFromLeft = 25;

  late double paddingFromBottom = 10;

  // Increase or Decrease when new user logged in or logged out
  late int online = 0;

  late int totalFriends = 0;

  /////////////////////////////////////////////////////////////
  // This is a friends list which pulled from the database
  late List<String> friendsList = <String>[
    'KingOfSports',
    'YouCantBeatMe',
    'HealtyBetty',
    'ProffesorHealthCare',
    'DoctorSports',
    'ImGreat',
  ];

  late List<bool> isOnline = <bool>[
    true,
    true,
    false,
    false,
    false,
    false,
  ];

  // Bu iki fonksiyon online olan kişileri ve toplam arkadaş listesindeki kişi sayısını güncellemeyi sağlıyor.
  int TotalCount() {
    totalFriends = friendsList.length;
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

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromRGBO(0, 31, 235,0.6),
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
              itemCount: friendsList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.only(
                    left: paddingFromLeft,
                    bottom: paddingFromBottom,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        // Will change with friends list's name
                        '${friendsList[index]}',
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

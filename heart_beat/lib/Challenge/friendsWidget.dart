import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import '../FriendShip/FriendShipActions.dart';
import 'ChallengeFirebaseData.dart';
import 'challengeWidget.dart';

void show_SelectFirst(BuildContext context) {
  Flushbar(
    duration: Duration(seconds: 3),
    margin: EdgeInsets.all(8),
    padding: EdgeInsets.all(10),

    backgroundGradient: LinearGradient(
      colors: [
        Colors.red.shade500,
        Colors.red.shade300,
        Colors.red.shade100
      ],
      stops: [0.4, 0.7, 1],
    ),
    boxShadows: [
      BoxShadow(
        color: Colors.black45,
        offset: Offset(3, 3),
        blurRadius: 3,
      ),
    ],
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
    title: 'No selection made!',
    message: 'please select the friend you want to challenge.',
    messageSize: 17,
  )..show(context);
}
class Friends extends StatefulWidget {
  const Friends({Key? key}) : super(key: key);

  @override
  State<Friends> createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  int selectedIndex = -1;
  // For search engine
  TextEditingController searchController = TextEditingController();
  List<String> userNames = [];
  var idItems = [];

  // SEARCHING ALGORTIHM
  void FilterSearchResults(String query) {
    List<String> dummySearchList = [];
    dummySearchList.addAll(userNames);
    if (query.isNotEmpty) {
      List<String> dummyListData = [];

      dummySearchList.asMap().forEach((value, item) {
        if (item.contains(query)) {
          dummyListData.add(item);
          print(value);
          indexOfButtons.add(value);
          print(indexOfButtons);
        }
      });
      setState(() {
        idItems.clear();
        idItems.addAll(dummyListData);
        // BU FOR DÖNGÜSÜYTLE UĞRAŞ AGAAAAAAAAAAAAAA
        for (int i = 0; i < buttonItems.length; i++) {
          for (int j = 0; j < indexOfButtons.length; j++) {
            if (buttonItems[i] == buttonItems[j]) {
              if (buttonItems[i] && !buttonItems[indexOfButtons[j]]) {
                setState(() {
                  buttonItems[i] = !buttonItems[i];
                });
              } else if (!buttonItems[i] && buttonItems[indexOfButtons[j]]) {
                setState(() {
                  buttonItems[i] = !buttonItems[i];
                });
              }
            }
          }
        }
        //////////////////////////
      });
      return;
    } else {
      setState(() {
        idItems.clear();
        idItems.addAll(userNames);
        setState(() {
          for (int i = 0; i < buttonItems.length; i++) {
            for (int j = 0; j < indexOfButtons.length; j++) {
              if ((i - 1) == indexOfButtons[j]) {
                if (!buttonItems[i] && buttonItems[indexOfButtons[j]]) {
                  setState(() {
                    buttonItems[j] = !buttonItems[j];
                  });
                }
              }
            }
          }
        });
        indexOfButtons.clear();
      });
    }
  }

  // This list for add friend button
  List<bool> buttonItems = [];
  List<int> indexOfButtons = [];
  List<Userz> friendsSet = [];

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    friendsSet = await showFriendsSetData();
    super.setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // This "for" is for buttons
    for (int i = 0; i < 20; i++) {
      buttonItems.add(false);
    }
    for (int i = 0; i < 20; i++) {
      // WILL PULL FROM DATABASE
      userNames.add("User $i");
      idItems.add(userNames[i]);
      ////////////////////////////
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 31, 235,0.6),
        title: Text("Firends List"),
        titleTextStyle: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Column(
        children: <Widget>[
          // SEARCH ENGİNE
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                FilterSearchResults(value);
              },
              decoration: InputDecoration(
                labelText: "Find Friend",
                hintText: "Search ...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
          ),
          // LIST PART
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: friendsSet.length,
            itemBuilder: (BuildContext context, int index) {
              // EVERY ELEMENT OF THE LIST
              return InkWell(
                onTap: () => setState(() => selectedIndex=index),
                //color: Colors.white,
                child: Card(
                  shadowColor: (selectedIndex==index)? Colors.green: null,
                  shape: (selectedIndex==index)
                      ? RoundedRectangleBorder(
                      side: BorderSide(color: Colors.green))
                      : null,
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
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(selectedIndex==-1){
            show_SelectFirst(context);
          }
          else if(selectedIndex>-1){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => challenges(selectedUserData: friendsSet[selectedIndex],),));
          }
        },
        child: const Icon(Icons.navigate_next),
        backgroundColor: Color.fromRGBO(0, 31, 235,0.6),
      ),

    );
  }
}

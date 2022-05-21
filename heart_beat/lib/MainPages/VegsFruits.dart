import 'package:another_flushbar/flushbar.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat/XP/actions.dart';
import 'MainMenu.dart';

class VegsFruits extends StatefulWidget {
  const VegsFruits({Key? key}) : super(key: key);

  @override
  _VegsFruitsState createState() => _VegsFruitsState();
}

class _VegsFruitsState extends State<VegsFruits> {
   ConfettiController? controllerTopCenter;

  @override
  void initState() {
    // TODO: implement initState
    if(mounted){
      setState(() {
        controllerTopCenter = ConfettiController(duration: const Duration(seconds: 1));
        super.initState();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(0, 31, 235,0.6),
          title: Text("Fruits&Vegs Page"),
          titleTextStyle: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
          leading: IconButton(icon:Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainMenuPage()),
              );
            },),
        ),
        body: Center(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(left: 20,top: 50)),
              Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: 60)),
                  SizedBox(
                    child: Column(
                      children: [
                        ClipRRect(
                          child: Image.network(
                            "https://firebasestorage.googleapis.com/v0/b/heartbeat-cbae0.appspot.com/o/Vegs%2Fapple.png?alt=media&token=b6009618-6c2d-4713-b793-65391501b4d5",
                            height: 80,
                            width: 80,),
                        ),
                        IconButton(
                            onPressed: (){
                              EarnXp(5);
                              show_SelectFirst(context);
                              controllerTopCenter!.play();
                            },
                            icon: Icon(Icons.add)),
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 30)),
                  SizedBox(
                    child: Column(
                      children: [
                        ClipRRect(
                          child: Image.network(
                            "https://firebasestorage.googleapis.com/v0/b/heartbeat-cbae0.appspot.com/o/Vegs%2Fdragon-fruit.png?alt=media&token=fb44d9b5-22be-4b98-a228-22e3ae8c9f2b",
                            height: 80,
                            width: 80,),
                        ),
                        IconButton(
                            onPressed: (){},
                            icon: Icon(Icons.add)),
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 30)),
                  SizedBox(
                    child: Column(
                      children: [
                        ClipRRect(
                          child: Image.network(
                            "https://firebasestorage.googleapis.com/v0/b/heartbeat-cbae0.appspot.com/o/Vegs%2Fwatermelon.png?alt=media&token=f7c0ba05-700e-408d-929d-90507f936ba5",
                            height: 80,
                            width: 80,),
                        ),
                        IconButton(
                            onPressed: (){},
                            icon: Icon(Icons.add)),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(left: 20,top: 50)),
              Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: 60)),
                  SizedBox(
                    child: Column(
                      children: [
                        ClipRRect(
                          child: Image.network(
                            "https://firebasestorage.googleapis.com/v0/b/heartbeat-cbae0.appspot.com/o/Vegs%2Flemon.png?alt=media&token=dc34f405-0cfd-40d0-b051-61ba79debaef",
                            height: 80,
                            width: 80,),
                        ),
                        IconButton(
                            onPressed: (){},
                            icon: Icon(Icons.add)),
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 30)),
                  SizedBox(
                    child: Column(
                      children: [
                        ClipRRect(
                          child: Image.network(
                            "https://firebasestorage.googleapis.com/v0/b/heartbeat-cbae0.appspot.com/o/Vegs%2Fstrawberry.png?alt=media&token=0446c8ca-eb59-42a4-ade8-18b8405755dc",
                            height: 80,
                            width: 80,),
                        ),
                        IconButton(
                            onPressed: (){},
                            icon: Icon(Icons.add)),
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 30)),
                  SizedBox(
                    child: Column(
                      children: [
                        ClipRRect(
                          child: Image.network(
                            "https://firebasestorage.googleapis.com/v0/b/heartbeat-cbae0.appspot.com/o/Vegs%2Forange-juice.png?alt=media&token=509b4662-05f9-41ca-9ef7-e0d055b6b61f",
                            height: 80,
                            width: 80,),
                        ),
                        IconButton(
                            onPressed: (){},
                            icon: Icon(Icons.add)),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(left: 20,top: 50)),
              Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: 60)),
                  SizedBox(
                    child: Column(
                      children: [
                        ClipRRect(
                          child: Image.network(
                            "https://firebasestorage.googleapis.com/v0/b/heartbeat-cbae0.appspot.com/o/Vegs%2Fdurian.png?alt=media&token=bccd9213-8046-429a-83f0-37c6d6bd3c88",
                            height: 80,
                            width: 80,),
                        ),
                        IconButton(
                            onPressed: (){},
                            icon: Icon(Icons.add)),
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 30)),
                  SizedBox(
                    child: Column(
                      children: [
                        ClipRRect(
                          child: Image.network(
                            "https://firebasestorage.googleapis.com/v0/b/heartbeat-cbae0.appspot.com/o/Vegs%2Fgrapes.png?alt=media&token=3cca8518-ac8a-4c50-b95b-be92136841c7",
                            height: 80,
                            width: 80,),
                        ),
                        IconButton(
                            onPressed: (){},
                            icon: Icon(Icons.add)),
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 30)),
                  SizedBox(
                    child: Column(
                      children: [
                        ClipRRect(
                          child: Image.network(
                            "https://firebasestorage.googleapis.com/v0/b/heartbeat-cbae0.appspot.com/o/Vegs%2Fmango.png?alt=media&token=f0cc8c79-ca66-46bb-945c-4bd746eaa4b7",
                            height: 80,
                            width: 80,),
                        ),
                        IconButton(
                            onPressed: (){},
                            icon: Icon(Icons.add)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      onWillPop: () async{
        Navigator.pushAndRemoveUntil<void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => MainMenuPage(),
          ),
              (Route<dynamic> route) => false,
        );
        return true;
      },
    );
  }
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
      title: 'Yupppy!',
      message: 'You earned 5 XPs',
      messageSize: 17,
    )..show(context);
  }
}

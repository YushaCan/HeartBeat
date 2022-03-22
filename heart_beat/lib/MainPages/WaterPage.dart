import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:line_icons/line_icons.dart';

class WaterPage extends StatelessWidget {
  const WaterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Water Management",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Water Management"),
          backgroundColor: Colors.lightBlue,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: WaterPageContent(),
      ),
    );
  }
}

class WaterPageContent extends StatefulWidget {
  WaterPageContent({Key? key}) : super(key: key);

  @override
  State<WaterPageContent> createState() => _WaterPageContentState();
}

class _WaterPageContentState extends State<WaterPageContent>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    animationController.addListener(() => setState(() {}));
    // CHANGE THE VALUE IN THE animeteTo dynamically with respect to consumed water
    animationController.animateTo(0.7);
    //////////////////////////////////////////////////////////////////////////////
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    // VALUE PERCENT
    final percentage = animationController.value * 100;
    ///////////////
    return Center(
      child: Stack(
        children: <Widget>[
          SizedBox(
            width: 300,
            height: 300,
            child: LiquidCircularProgressIndicator(
              value: animationController.value,
              direction: Axis.vertical,
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation(Colors.blue),
              center: Text(
                "${percentage.toStringAsFixed(0)}%",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Path BuildWaterPath() {
    return Path()
      ..moveTo(50, 0)
      ..quadraticBezierTo(0, 0, 0, 37.5)
      ..quadraticBezierTo(0, 75, 25, 75)
      ..quadraticBezierTo(25, 95, 5, 95)
      ..quadraticBezierTo(35, 95, 40, 75)
      ..quadraticBezierTo(100, 75, 100, 37.5)
      ..quadraticBezierTo(100, 0, 50, 0)
      ..close();
  }
}

import "package:flutter/material.dart";
import "package:pedometer/pedometer.dart";

class Steps extends StatefulWidget {
  @override
  _StepsState createState() => _StepsState();
}

class _StepsState extends State<Steps> {
  late Stream<StepCount> _stepCountStream;
  int _steps = 0;

  // Styles
  TextStyle _stepsTextStyle =
  TextStyle(fontSize: 32, fontWeight: FontWeight.w600);

  void initState() {
    super.initState();
    initStepCountState();
  }

  void onStepCount(StepCount event) {
    print(event);
    setState(() {
      _steps = event.steps;
    });
  }

  void initStepCountState() {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Center(
          child: Text(
            _steps.toString(),
            style: _stepsTextStyle,
            textAlign: TextAlign.center,
          ),
        ));
  }
}
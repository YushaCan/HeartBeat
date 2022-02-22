import 'package:flutter/material.dart';
import 'dart:async';
import 'package:pedometer/pedometer.dart';

class MyAppState extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyAppState> {
  String _stepCountValue = 'Unknown';
  late StreamSubscription<StepCount> _subscription;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    setUpPedometer();
    if (!mounted) return;
  }

  void setUpPedometer() {
    _subscription = Pedometer.stepCountStream.listen(_onData,
        onError: _onError, onDone: _onDone, cancelOnError: true);
  }

  void _onData(StepCount stepCountValue) async {
    setState(() => _stepCountValue = "$stepCountValue");
  }

  void _onDone() => print("Finished pedometer tracking");

  void _onError(error) => print("Flutter Pedometer Error: $error");

  void _onCancel() => _subscription.cancel();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Plugin example app'),
        ),
        body: new Center(
          child: new Text('$_stepCountValue\n'),
        ),
      ),
    );
  }
}
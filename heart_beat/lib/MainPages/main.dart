import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat/MainPages/SplashScreen.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_signup.dart';
import 'package:cron/cron.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool isFirstRun = false;
  String? action = '';
  @override
  void didChangeDependencies() async{
    super.didChangeDependencies();
    isFirstRun = await IsFirstRun.isFirstRun();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    action = prefs.getString('UID');
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: action!=null?
      const SplashScreenState()
      : const loginSignup(),
    );
  }
}


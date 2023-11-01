import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gymplus/app/views/view_onboarding/onboarding_view.dart';
import 'package:gymplus/app/views/view_tab_bar/tab_bar_view.dart';
import 'package:gymplus/core/constants/color_constants.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = NotificationService.flutterLocalNotificationsPlugin;

  @override
  initState() {
    super.initState();
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    final IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings();
    final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    tz.initializeTimeZones();

    flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: selectNotification);
  }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = FirebaseAuth.instance.currentUser != null;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness',
      theme: ThemeData(
        textTheme: const TextTheme(bodyLarge: TextStyle(color: ColorConstants.textColor)),
        fontFamily: 'NotoSansKR',
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: isLoggedIn ? const TabBarPage() : OnboardingPage(),
    );
  }

  Future selectNotification(String? payload) async {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("PayLoad"),
          content: Text("Payload : $payload"),
        );
      },
    );
  }
}
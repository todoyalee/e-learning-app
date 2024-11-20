import 'package:elearning/ui/pages/onboarding1.dart';
import 'package:elearning/ui/pages/undefinedScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:elearning/global/globals.dart' as globals;
import 'package:elearning/routes/router.dart' as router;
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with manual configuration
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCPSfZp67cSlYlmRls3toFshuIdVDfNsxE",
      authDomain: "learningapp-a0e2b.firebaseapp.com",
      projectId: "learningapp-a0e2b",
      storageBucket: "learningapp-a0e2b.appspot.com",
      messagingSenderId: "710554233710",
      appId: "1:710554233710:web:56c3c88e98d129d47baf7f",
      measurementId: "G-BN2M9FMH4K",
    ),
  );

  prefs = await SharedPreferences.getInstance();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(
            RestartWidget(
              child: MyApp(),
            ),
          ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void getLoginStatus() async {
    prefs = await SharedPreferences.getInstance();
    globals.gAuth.googleSignIn.isSignedIn().then((value) {
      prefs.setBool("isLoggedin", value);
    });
  }

  @override
  void initState() {
    getLoginStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      onGenerateRoute: router.generateRoute,
      onUnknownRoute: (settings) => CupertinoPageRoute(
          builder: (context) => UndefinedScreen(
                name: settings.name,
              )),
      debugShowCheckedModeBanner: false,
      home: Onboarding(),
    );
  }
}

class RestartWidget extends StatefulWidget {
  RestartWidget({this.child});

  final Widget? child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()!.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child!,
    );
  }
}

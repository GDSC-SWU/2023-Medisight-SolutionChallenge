import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:medisight/page/home.dart';
import 'package:medisight/page/tip_sub.dart';
import 'package:medisight/provider/google_sign_in.dart';
import 'package:medisight/widget/logged_in_widget.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Home Page',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: HomePage()));
}



/*
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:medisight/page/home.dart';
// import 'package:medisight/page/search_result.dart';
// import 'package:medisight/page/tip_sub.dart';
import 'package:medisight/provider/google_sign_in.dart';
import 'package:medisight/screen/bottom_navi.dart';
import 'package:medisight/widget/logged_in_widget.dart';
import 'package:provider/provider.dart';
import 'screen/home_screen.dart';
import 'screen/mypage_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Home Page',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: HomePage(),
        ),
      );
}

/*
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medisight',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      //BottomNavi(selectedIndex: 0),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  dispose() async {
    super.dispose();
  }
}
*/
*/
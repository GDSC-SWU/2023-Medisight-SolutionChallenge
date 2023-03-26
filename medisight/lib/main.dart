import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:medisight/page/home.dart';
import 'package:medisight/provider/google_sign_in.dart';
import 'package:medisight/theme/theme.dart';
import 'package:medisight/theme/theme_provider.dart';
import 'package:medisight/widget/logged_in_widget.dart';
import 'package:provider/provider.dart';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:medisight/provider/permission_provider.dart';
import 'package:medisight/service/alarm_polling_worker.dart';
import 'package:medisight/provider/alarm_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AndroidAlarmManager.initialize();

  final AlarmState alarmState = AlarmState();
  final SharedPreferences preference = await SharedPreferences.getInstance();
  ThemeMode themeMode = ThemeMode.light;

  // 저장된 테마모드 불러오기.
  final String? savedThemeMode = preference.getString('themeMode');
  if (savedThemeMode == null) {
    themeMode = ThemeMode.light;
  } else if (savedThemeMode == "light") {
    themeMode = ThemeMode.light;
  } else if (savedThemeMode == "dark") {
    themeMode = ThemeMode.dark;
  }

  // 앱 진입시 알람 탐색을 시작해야 한다.
  AlarmPollingWorker().createPollingWorker(alarmState);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => alarmState),
      ChangeNotifierProvider(
        create: (context) => PermissionProvider(preference),
      ),
    ],
    child: MyApp(themeMode: themeMode),
  ));
}

class MyApp extends StatefulWidget {
  final themeMode;
  const MyApp({super.key, required this.themeMode});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => GoogleSignInProvider()),
          ChangeNotifierProvider(
              // 어플리케이션이 실행되면서 Provider를 적용할 때 불러온 테마모드를 ThemeProvider에 넘겨줍니다.
              create: (_) => ThemeProvider(initThemeMode: widget.themeMode)),
        ],
        builder: (context, _) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Home Page',
              theme: MyThemes.lightTheme,
              darkTheme: MyThemes.darkTheme,
              themeMode: Provider.of<ThemeProvider>(context).themeMode,
              home: HomePage());
        });
  }
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
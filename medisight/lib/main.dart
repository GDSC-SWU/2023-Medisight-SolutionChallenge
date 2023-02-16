import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:medisight/page/home.dart';
// import 'package:medisight/page/search_result.dart';
// import 'package:medisight/page/tip_sub.dart';
import 'package:medisight/provider/google_sign_in.dart';
import 'package:medisight/widget/logged_in_widget.dart';
import 'package:provider/provider.dart';
import 'screen/home_screen.dart';
import 'screen/mypage_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Medisight',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MainPage(selectedIndex: 0));
  }
}

class MainPage extends StatefulWidget {
  final int selectedIndex;

  const MainPage({super.key, required this.selectedIndex});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  final List<Widget> pages = <Widget>[
    const HomeScreen(),
    const HomeScreen(),
    const MypageScreen(),
  ];

  late List<GlobalKey<NavigatorState>> navigatorKeyList = [];

  void onItemTapped(int index) {
    setState(() {
      if (index == 0) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const MainPage(selectedIndex: 0)),
          (route) => false,
        );
      } else if (index == 2) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const MainPage(selectedIndex: 2)),
          (route) => false,
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    navigatorKeyList =
        List.generate(pages.length, (index) => GlobalKey<NavigatorState>());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !(await navigatorKeyList[widget.selectedIndex]
            .currentState!
            .maybePop());
      },
      child: Scaffold(
        body: IndexedStack(
          index: widget.selectedIndex,
          children: pages.map((page) {
            int index = pages.indexOf(page);
            return Navigator(
              key: navigatorKeyList[index],
              onGenerateRoute: (_) {
                return MaterialPageRoute(builder: (context) => page);
              },
            );
          }).toList(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "홈",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.music_note),
              label: "음성",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "마이페이지",
            ),
          ],
          currentIndex: widget.selectedIndex,
          onTap: onItemTapped,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
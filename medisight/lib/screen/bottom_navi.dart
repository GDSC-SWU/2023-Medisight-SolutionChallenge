import 'package:flutter/material.dart';
import 'package:medisight/screen/camera_screen.dart';
import 'home_screen.dart';
import 'mypage_screen.dart';
import 'package:medisight/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class BottomNavi extends StatefulWidget {
  int selectedIndex;

  BottomNavi({super.key, required this.selectedIndex});

  @override
  BottomNaviState createState() => BottomNaviState();
}

class BottomNaviState extends State<BottomNavi> {
  final List<Widget> pages = <Widget>[
    const HomeScreen(),
    const CameraScreen(),
    const MypageScreen(),
  ];
  late List<GlobalKey<NavigatorState>> navigatorKeyList = [];

  void onItemTapped(int index) {
    setState(() {
      if (index == 0) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => BottomNavi(selectedIndex: 0)),
          (route) => false,
        );
      } else if (index == 1) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => BottomNavi(selectedIndex: 1)),
          (route) => false,
        );
      } else if (index == 2) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => BottomNavi(selectedIndex: 2)),
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
    final themeMode =
        Provider.of<ThemeProvider>(context, listen: false).themeMode;
    return WillPopScope(
      onWillPop: () async {
        return !(await navigatorKeyList[widget.selectedIndex]
            .currentState!
            .maybePop());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          child: Container(
            color: Theme.of(context).canvasColor,
            height: 70,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      iconSize: 30.0,
                      padding: EdgeInsets.only(left: 60.0),
                      icon: Icon(Icons.home,
                          color: widget.selectedIndex == 0
                              ? (themeMode == ThemeMode.light
                                  ? Color.fromARGB(255, 107, 134, 255)
                                  : Color.fromARGB(255, 255, 214, 0))
                              : (themeMode == ThemeMode.light
                                  ? Colors.black
                                  : Colors.white)),
                      onPressed: () {
                        onItemTapped(0);
                      },
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 60.0),
                      child: Text(
                        '홈',
                        style: TextStyle(
                            color: widget.selectedIndex == 0
                                ? (themeMode == ThemeMode.light
                                    ? Color.fromARGB(255, 107, 134, 255)
                                    : Color.fromARGB(255, 255, 214, 0))
                                : (themeMode == ThemeMode.light
                                    ? Colors.black
                                    : Colors.white),
                            height: 0.7),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      iconSize: 30.0,
                      padding: EdgeInsets.only(right: 50.0),
                      icon: Icon(Icons.person,
                          color: widget.selectedIndex == 2
                              ? (themeMode == ThemeMode.light
                                  ? Color.fromARGB(255, 107, 134, 255)
                                  : Color.fromARGB(255, 255, 214, 0))
                              : (themeMode == ThemeMode.light
                                  ? Colors.black
                                  : Colors.white)),
                      onPressed: () {
                        onItemTapped(2);
                      },
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 50.0),
                      child: Text(
                        '마이페이지',
                        style: TextStyle(
                            color: widget.selectedIndex == 2
                                ? (themeMode == ThemeMode.light
                                    ? Color.fromARGB(255, 107, 134, 255)
                                    : Color.fromARGB(255, 255, 214, 0))
                                : (themeMode == ThemeMode.light
                                    ? Colors.black
                                    : Colors.white),
                            height: 0.7),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: Navigator(
            key: navigatorKeyList[widget.selectedIndex],
            onGenerateRoute: (_) {
              return MaterialPageRoute(
                  builder: (context) => pages[widget.selectedIndex]);
            }),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(top: 100.0),
          child: Container(
            height: 70.0,
            width: 70.0,
            child: FittedBox(
              child: FloatingActionButton(
                onPressed: () {
                  onItemTapped(1);
                },
                child: Icon(
                  Icons.camera_alt_outlined,
                  color: themeMode == ThemeMode.light
                      ? Colors.white
                      : Colors.black,
                ),
                elevation: 0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

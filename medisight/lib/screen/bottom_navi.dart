import 'package:flutter/material.dart';
import 'package:medisight/screen/camera_screen.dart';
import 'home_screen.dart';
import 'mypage_screen.dart';

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
    return WillPopScope(
      onWillPop: () async {
        return !(await navigatorKeyList[widget.selectedIndex]
            .currentState!
            .maybePop());
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 100,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  iconSize: 30.0,
                  padding: EdgeInsets.only(left: 60.0),
                  icon: Icon(Icons.home,
                      color: widget.selectedIndex == 0
                          ? Colors.blue
                          : Colors.black),
                  onPressed: () {
                    onItemTapped(0);
                  },
                ),
                IconButton(
                  iconSize: 30.0,
                  padding: EdgeInsets.only(right: 60.0),
                  icon: Icon(Icons.person,
                      color: widget.selectedIndex == 2
                          ? Colors.blue
                          : Colors.black),
                  onPressed: () {
                    onItemTapped(2);
                  },
                )
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
                  color: Colors.white,
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

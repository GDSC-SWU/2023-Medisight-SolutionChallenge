import 'package:flutter/material.dart';
import 'package:medisight/screen/shoot_qr.dart';
import 'home_screen.dart';
import 'mypage_screen.dart';

class BottomNavi extends StatefulWidget {
  const BottomNavi({Key? key}) : super(key: key);

  @override
  _BottomNaviState createState() => _BottomNaviState();
}

class _BottomNaviState extends State<BottomNavi> {
  int selectedIndex = 0;
  final List<Widget> pages = <Widget>[
    HomeScreen(),
    ShootQr(),
    MypageScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "홈",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: "카메라",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "마이페이지",
          ),
        ],
        currentIndex: selectedIndex,
        onTap: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

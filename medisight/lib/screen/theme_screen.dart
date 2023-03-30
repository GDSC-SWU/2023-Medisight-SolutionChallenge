import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medisight/screen/bottom_navi.dart';
import 'package:medisight/theme/animated_toggle_button.dart';
import 'package:provider/provider.dart';

import '../theme/theme_provider.dart';
import 'mypage_screen.dart';
import 'tuto_screen.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({Key? key}) : super(key: key);
  @override
  _ThemeScreen createState() => _ThemeScreen();
}

class _ThemeScreen extends State<ThemeScreen>
    with SingleTickerProviderStateMixin {
  final user = FirebaseAuth.instance.currentUser!;
  bool getSavedThemeMode() {
    final themeMode =
        Provider.of<ThemeProvider>(context, listen: false).themeMode;

    if (themeMode == ThemeMode.light) {
      isDarkMode = false;
      _animationController.reverse(from: 1.0);
    } else if (themeMode == ThemeMode.dark) {
      isDarkMode = true;
      _animationController.forward(from: 0.0);
    }

    return isDarkMode;
  }

  late AnimationController _animationController;
  bool isDarkMode = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ThemeColor lightMode = ThemeColor(
    gradient: [
      const Color(0xDDFF0080),
      const Color(0xDDFF8C00),
    ],
    backgroundColor: const Color(0xFFFFFFFF),
    textColor: const Color(0xFF000000),
    toggleButtonColor: const Color(0xFFFFFFFF),
    toggleBackgroundColor: const Color(0xFFe7e7e8),
    shadow: const [
      BoxShadow(
        color: const Color(0xFFd8d7da),
        spreadRadius: 5,
        blurRadius: 10,
        offset: Offset(0, 5),
      ),
    ],
  );

  ThemeColor darkMode = ThemeColor(
    gradient: [
      const Color(0xFF8983F7),
      const Color(0xFFA3DAFB),
    ],
    backgroundColor: const Color(0xFF26242e),
    textColor: const Color(0xFFFFFFFF),
    toggleButtonColor: const Color(0xFf34323d),
    toggleBackgroundColor: const Color(0xFF222029),
    shadow: const <BoxShadow>[
      BoxShadow(
        color: const Color(0x66000000),
        spreadRadius: 5,
        blurRadius: 10,
        offset: Offset(0, 5),
      ),
    ],
  );

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    getSavedThemeMode();
    super.initState();
  }

  changeThemeMode() {
    if (isDarkMode) {
      final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
      themeProvider.setThemeMode(ThemeMode.dark);
      _animationController.forward(from: 0.0);
    } else {
      final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
      themeProvider.setThemeMode(ThemeMode.light);
      _animationController.reverse(from: 1.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    isDarkMode = getSavedThemeMode();

    return Scaffold(
      appBar: AppBar(
        title: Text("테마 설정"),
        leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const MypageScreen()),
              (route) => false,
            );
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      key: _scaffoldKey,
      backgroundColor:
          isDarkMode ? darkMode.backgroundColor : lightMode.backgroundColor,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: height * 0.1),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    width: width * 0.35,
                    height: width * 0.35,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors:
                            isDarkMode ? darkMode.gradient : lightMode.gradient,
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(40, 0),
                    child: ScaleTransition(
                      scale: _animationController.drive(
                        Tween<double>(begin: 0.0, end: 1.0).chain(
                          CurveTween(curve: Curves.decelerate),
                        ),
                      ),
                      alignment: Alignment.topRight,
                      child: Container(
                        width: width * 0.26,
                        height: width * 0.26,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isDarkMode
                              ? darkMode.backgroundColor
                              : lightMode.backgroundColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.1,
              ),
              Text(
                '테마를 선택하세요',
                style: TextStyle(
                  color: isDarkMode ? darkMode.textColor : lightMode.textColor,
                  fontSize: width * 0.06,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Rubik',
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Container(
                width: width * 0.7,
                child: Text(
                  '기본 테마와 고대비 테마 중 선택하세요',
                  style: TextStyle(
                    color:
                        isDarkMode ? darkMode.textColor : lightMode.textColor,
                    fontSize: width * 0.04,
                    fontFamily: 'Rubik',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: height * 0.06,
              ),
              AnimatedToggle(
                isDarkMode: isDarkMode,
                values: ['기본', '고대비'],
                textColor:
                    isDarkMode ? darkMode.textColor : lightMode.textColor,
                backgroundColor: isDarkMode
                    ? darkMode.toggleBackgroundColor
                    : lightMode.toggleBackgroundColor,
                buttonColor: isDarkMode
                    ? darkMode.toggleButtonColor
                    : lightMode.toggleButtonColor,
                shadows: isDarkMode ? darkMode.shadow : lightMode.shadow,
                onToggleCallback: (index) {
                  isDarkMode = !isDarkMode;
                  setState(() {});
                  changeThemeMode();
                },
              ),
              SizedBox(
                height: height * 0.05,
                width: width,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ThemeColor {
  List<Color> gradient;
  Color backgroundColor;
  Color toggleButtonColor;
  Color toggleBackgroundColor;
  Color textColor;
  List<BoxShadow> shadow;

  ThemeColor({
    required this.gradient,
    required this.backgroundColor,
    required this.toggleBackgroundColor,
    required this.toggleButtonColor,
    required this.textColor,
    required this.shadow,
  });
}

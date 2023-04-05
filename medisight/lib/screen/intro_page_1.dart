import 'package:flutter/material.dart';
import 'package:medisight/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class IntroPage1 extends StatefulWidget {
  const IntroPage1({super.key});

  @override
  State<IntroPage1> createState() => _IntroPage1State();
}

class _IntroPage1State extends State<IntroPage1> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode =
        Provider.of<ThemeProvider>(context, listen: false).themeMode;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DecoratedBox(
              decoration: BoxDecoration(
                  color: themeMode == ThemeMode.light
                      ? Colors.white
                      : Theme.of(context).canvasColor,
                  border: Border.all(
                    width: 3,
                    color: themeMode == ThemeMode.light
                        ? Color.fromARGB(0, 255, 213, 0)
                        : Color.fromARGB(255, 255, 214, 0),
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.2), //shadow for button
                        blurRadius: 5) //blur radius of shadow
                  ]),
              child: Container(
                padding: const EdgeInsets.only(
                    left: 30, top: 30, right: 30, bottom: 30),
                width: 350,
                height: 600,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        '촬영 페이지',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '하단에 위치한 의약품 촬영 버튼과 유효기간 촬영 버튼을 통해 소지하고 계신 의약품을 촬영할 수 있습니다.',
                        style: TextStyle(fontSize: 16, height: 1.75),
                      ),
                      SizedBox(height: 20),
                      Text(
                        '1. 의약품 촬영',
                        style: TextStyle(
                            fontSize: 16,
                            height: 1.75,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '- 초기 진입 시 카메라 접근에 대한 권한을 허용해 주세요.\n- 진입 시 카메라가 켜집니다.\n- 바코드 및 QR코드가 스캔 되면 비프음과 진동이 울리고 약품 정보가 출력됩니다.',
                        style: TextStyle(fontSize: 16, height: 1.75),
                      ),
                      SizedBox(height: 20),
                      Text(
                        '2. 사용기한 촬영',
                        style: TextStyle(
                            fontSize: 16,
                            height: 1.75,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '- 초기 진입 시 카메라 접근에 대한 권한을 허용해 주세요.\n- 진입 시 카메라가 켜집니다.\n- 손 위치를 안내음에 따라 움직여주세요.\n- 완료 시 사용기한이 출력됩니다.',
                        style: TextStyle(fontSize: 16, height: 1.75),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

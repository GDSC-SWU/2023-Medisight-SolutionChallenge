import 'package:flutter/material.dart';
import 'package:medisight/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class IntroPage4 extends StatefulWidget {
  const IntroPage4({super.key});

  @override
  State<IntroPage4> createState() => _IntroPage4State();
}

class _IntroPage4State extends State<IntroPage4> {
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
                        '기타 편의 기능',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      Text(
                        '1. 기저질환 설정',
                        style: TextStyle(
                            fontSize: 16,
                            height: 1.75,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '- 앱 초기설정 및 마이페이지에서 설정할 수 있습니다.\n- 사용자의 기저질환을 선택하여 복용 시 유의해야 할 약품을 알 수 있습니다.',
                        style: TextStyle(fontSize: 16, height: 1.75),
                      ),
                      SizedBox(height: 20),
                      Text(
                        '2. 테마 설정',
                        style: TextStyle(
                            fontSize: 16,
                            height: 1.75,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '- 마이페이지에서 설정할 수 있습니다.\n- 기본 및 고대비 테마로 변경할 수 있습니다.',
                        style: TextStyle(fontSize: 16, height: 1.75),
                      ),
                      SizedBox(height: 20),
                      Text(
                        '3. 상식 페이지',
                        style: TextStyle(
                            fontSize: 16,
                            height: 1.75,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '- 의약품 복용, 보관, 성분에 대한 상식과 증상별 의약품 정보를 제공합니다.\n- 더 많은 정보를 위해 의약품 안전 나라 웹으로 이동하는 버튼이 상단에 있습니다.',
                        style: TextStyle(fontSize: 16, height: 1.75),
                      ),
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

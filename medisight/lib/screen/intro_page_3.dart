import 'package:flutter/material.dart';
import 'package:medisight/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class IntroPage3 extends StatefulWidget {
  const IntroPage3({super.key});

  @override
  State<IntroPage3> createState() => _IntroPage3State();
}

class _IntroPage3State extends State<IntroPage3> {
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
                        '알람 페이지',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '현재 소지하고 계신 약품을 등록하여 사용기한과 특정 복용 시간을 설정해 알람을 사용할 수 있습니다.',
                        style: TextStyle(fontSize: 16, height: 1.75),
                      ),
                      SizedBox(height: 20),
                      Text(
                        '1. 알람 추가',
                        style: TextStyle(
                            fontSize: 16,
                            height: 1.75,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '- 오른쪽 하단에 추가 버튼을 눌러 알람을 추가하세요.\n- 약품명을 입력하고 해당 약품의 사용기한을 직접 기입하거나 카메라 촬영 버튼을 통해 인식하여 등록이 가능합니다.\n- 키보드 입력으로 알람 시간을 설정해 주세요.\n- 반복될 요일을 선택하고 토글 버튼을 이용해 소리와 진동을 설정하세요.\n마지막으로 추가하기 버튼을 눌러 알람 등록을 완료하세요. 누락된 정보가 있을 시 알림이 뜹니다.',
                        style: TextStyle(fontSize: 16, height: 1.75),
                      ),
                      SizedBox(height: 20),
                      Text(
                        '2. 알람 수정 및 삭제',
                        style: TextStyle(
                            fontSize: 16,
                            height: 1.75,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '- 등록된 알람을 선택할 시 수정할 수 있습니다.\n- 삭제 버튼을 통해 해당 알람을 삭제할 수 있습니다.\n- 알람 토글버튼을 이용해 알람 해제를 할 수 있습니다.',
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

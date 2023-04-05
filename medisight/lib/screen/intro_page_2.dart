import 'package:flutter/material.dart';
import 'package:medisight/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class IntroPage2 extends StatefulWidget {
  const IntroPage2({super.key});

  @override
  State<IntroPage2> createState() => _IntroPage2State();
}

class _IntroPage2State extends State<IntroPage2> {
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
                        '지도 페이지',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '현재 위치를 기반으로 근처 약국을 검색할 수 있으며 도보 경로를 안내합니다.',
                        style: TextStyle(fontSize: 16, height: 1.75),
                      ),
                      SizedBox(height: 20),
                      Text(
                        '1. 근처 약국 검색 결과',
                        style: TextStyle(
                            fontSize: 16,
                            height: 1.75,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '- 지도 페이지 초기 진입 시, 현재 위치를 기반으로 근처 약국 약국명과 상세 주소를 보여줍니다.',
                        style: TextStyle(fontSize: 16, height: 1.75),
                      ),
                      SizedBox(height: 20),
                      Text(
                        '2. 도보 경로 안내',
                        style: TextStyle(
                            fontSize: 16,
                            height: 1.75,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '- 약국을 선택하면 경로 안내를 시작합니다.\n- 페이지 상단에는 약국까지 남은 거리와 시간을 알려줍니다.\n- 페이지의 중앙에는 현재 이동 위치와 거리를 알려주고 있으며 바로 아래 버튼에는 지도 보기 기능이 있습니다.\n- 지도 보기를 누르면 실제 지도 화면으로 넘어가게 되며, 현재 지도상의 경로를 보여줍니다.\n- 지도 보기 화면에서 다시 돌아가고 싶다면 경로 안내 버튼을 누르면 됩니다.\n- 지도 보기 하단에는 앞으로의 경로 안내가 준비되어 있습니다.',
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

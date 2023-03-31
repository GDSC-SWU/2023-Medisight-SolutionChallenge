import 'package:flutter/material.dart';
import 'shoot_period.dart';
import 'shoot_qr.dart';

import 'package:medisight/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_tts/flutter_tts.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    late FlutterTts tts = FlutterTts();
    tts.speak('촬영 페이지');
    final themeMode =
        Provider.of<ThemeProvider>(context, listen: false).themeMode;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: themeMode == ThemeMode.light
            ? Image.asset('assets/images/logo-title-light.png',
                width: 180, height: 200)
            : Image.asset('assets/images/logo-title-dark.png',
                width: 180, height: 200),
      ),
      body: Center(
        child: SingleChildScrollView(
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
                          color:
                              Color.fromRGBO(0, 0, 0, 0.2), //shadow for button
                          blurRadius: 5) //blur radius of shadow
                    ]),
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 20, top: 10, right: 10, bottom: 10),
                  width: 350,
                  height: 400,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '카메라 사용이 어렵다면\n이렇게 해보세요!',
                            style: TextStyle(
                                color: themeMode == ThemeMode.light
                                    ? Colors.black
                                    : Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Image.asset('assets/images/img_question.png',
                              width: 120, height: 140)
                        ],
                      ),
                      Text(
                        '카메라는 스마트폰의 후면 상단에 있으니,\n약품을 왼손으로 들고 오른손으로 스마트폰 하단을 잡아주세요.',
                        style: TextStyle(
                            color: themeMode == ThemeMode.light
                                ? Colors.black
                                : Colors.white,
                            fontSize: 16,
                            height: 1.75),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '3초마다 자동으로 촬영되며 안내음에 따라 의약품을 천천히 움직이며 정면, 후면, 측면을 촬영해주세요.',
                        style: TextStyle(
                            color: themeMode == ThemeMode.light
                                ? Colors.black
                                : Colors.white,
                            fontSize: 16,
                            height: 1.75),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // 의약품 촬영 버튼
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(160, 140),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(Icons.medical_services_outlined,
                            size: 40,
                            color: Color.fromARGB(255, 107, 134, 255)),
                        SizedBox(height: 5),
                        Text(
                          "의약품 촬영",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ShootQr(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 31),
                  // 사용기한 촬영 버튼
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(160, 140),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(Icons.date_range_outlined,
                            size: 40,
                            color: Color.fromARGB(255, 107, 134, 255)),
                        SizedBox(height: 5),
                        Text(
                          "사용기한 촬영",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const ShootPeriod(
                                  isFrom: 'camera',
                                  alarm: null,
                                )),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

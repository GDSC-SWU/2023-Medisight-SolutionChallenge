import 'package:flutter/material.dart';
import 'package:medisight/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import '../page/tip_sub_1.dart';
import '../page/tip_sub_2.dart';
import '../page/tip_sub_3.dart';
import '../page/tip_sub_4.dart';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode =
        Provider.of<ThemeProvider>(context, listen: false).themeMode;
    late FlutterTts tts = FlutterTts();
    tts.speak('상식 페이지');
    return Scaffold(
      appBar: AppBar(
          title: themeMode == ThemeMode.light
              ? Image.asset('assets/images/logo-title-light.png',
                  width: 180, height: 200)
              : Image.asset('assets/images/logo-title-dark.png',
                  width: 180, height: 200)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 30), // 여백
            // 상식 버튼
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).canvasColor,
                fixedSize: const Size(355, 140),
                //버튼을 둥글게 처리
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: _launchUrl,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '더 많은\n정보를 얻고싶다면?',
                        style: TextStyle(
                          color: themeMode == ThemeMode.light
                              ? Colors.black
                              : Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '의약품안전나라로 이동',
                        style: TextStyle(
                          color: themeMode == ThemeMode.light
                              ? Colors.black
                              : Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Image.asset('assets/images/img_store.png',
                      width: 120, height: 160),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              '원하시는 주제를 선택하세요',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 30), // 여백
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // 의약품 보관 버튼
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeMode == ThemeMode.light
                        ? Colors.blue.shade50
                        : Theme.of(context).canvasColor,
                    foregroundColor: Colors.black,
                    fixedSize: const Size(170, 160),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.add_box,
                          size: 40, color: Color.fromARGB(255, 107, 134, 255)),
                      Text(
                        "의약품 보관하기",
                        style: TextStyle(
                          fontSize: 16,
                          color: themeMode == ThemeMode.light
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const TipSubPage1()),
                    );
                  },
                ),

                const SizedBox(width: 15), // 여백
                // 의약품 복용 버튼
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeMode == ThemeMode.light
                        ? Colors.blue.shade50
                        : Theme.of(context).canvasColor,
                    foregroundColor: Colors.black,
                    fixedSize: const Size(170, 160),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.food_bank,
                          size: 40, color: Color.fromARGB(255, 107, 134, 255)),
                      Text(
                        "의약품 복용하기",
                        style: TextStyle(
                          fontSize: 16,
                          color: themeMode == ThemeMode.light
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const TipSubPage2()),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 15), // 여백
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // 증상별 의약품 버튼
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeMode == ThemeMode.light
                        ? Colors.blue.shade50
                        : Theme.of(context).canvasColor,
                    foregroundColor: Colors.black,
                    fixedSize: const Size(170, 160),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.medication,
                          size: 40, color: Color.fromARGB(255, 107, 134, 255)),
                      Text(
                        "증상별 의약품",
                        style: TextStyle(
                          fontSize: 16,
                          color: themeMode == ThemeMode.light
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const TipSubPage3()),
                    );
                  },
                ),
                const SizedBox(width: 15), // 여백

                // 의약품 성분 풀이 버튼
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeMode == ThemeMode.light
                        ? Colors.blue.shade50
                        : Theme.of(context).canvasColor,
                    foregroundColor: Colors.black,
                    fixedSize: const Size(170, 160),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.medical_information,
                          size: 40, color: Color.fromARGB(255, 107, 134, 255)),
                      Text(
                        "의약품 성분 풀이",
                        style: TextStyle(
                          fontSize: 16,
                          color: themeMode == ThemeMode.light
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const TipSubPage4()),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl() async {
    Uri _url = Uri.parse('https://nedrug.mfds.go.kr/cntnts/34');
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}

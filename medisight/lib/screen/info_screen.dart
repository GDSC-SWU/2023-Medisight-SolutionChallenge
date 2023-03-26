import 'package:flutter/material.dart';
import '../page/tip_sub_1.dart';
import '../page/tip_sub_2.dart';
import '../page/tip_sub_3.dart';
import '../page/tip_sub_4.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Image.asset('assets/images/medisight_logo.png',
              width: 200, height: 200)),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                '상식 페이지',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0),
              ),
              const SizedBox(height: 10),
              const Text(
                '원하시는 주제를 선택하세요',
                style: TextStyle(fontSize: 20, letterSpacing: 2.0),
              ),
              const SizedBox(height: 30),
              // 의약품 보관 버튼
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  minimumSize: const Size(350, 80),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text(
                  "의약품 보관하기",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const TipSubPage1()),
                  );
                },
              ),
              const SizedBox(height: 30), // 여백
              // 의약품 복용 버튼
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  minimumSize: const Size(350, 80),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text(
                  "의약품 복용하기",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const TipSubPage2()),
                  );
                },
              ),
              const SizedBox(height: 30), // 여백
              // 증상별 의약품 버튼
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  minimumSize: const Size(350, 80),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text(
                  "증상별 의약품",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const TipSubPage3()),
                  );
                },
              ),
              const SizedBox(height: 30), // 여백
              // 의약품 성분 풀이 버튼
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  minimumSize: const Size(350, 80),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text(
                  "의약품 성분 풀이",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const TipSubPage4()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:medisight/screen/store_medi.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "상식",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0.0, // 앱 바가 떠있는 효과 제거
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 30), // 여백
            // 의약품 보관 버튼
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black, backgroundColor: Colors.blue,
                minimumSize: const Size(350, 80),
                //버튼을 둥글게 처리
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text(
                "의약품 보관하기",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {},
            ),
            const SizedBox(height: 30), // 여백
            // 의약품 복용 버튼
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black, backgroundColor: Colors.blue,
                minimumSize: const Size(350, 80),
                //버튼을 둥글게 처리
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text(
                "의약품 복용하기",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {},
            ),
            const SizedBox(height: 30), // 여백
            // 증상별 의약품 버튼
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black, backgroundColor: Colors.blue,
                minimumSize: const Size(350, 80),
                //버튼을 둥글게 처리
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text(
                "증상별 의약품",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {},
            ),
            const SizedBox(height: 30), // 여백
            // 의약품 성분 풀이 버튼
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black, backgroundColor: Colors.blue,
                minimumSize: const Size(350, 80),
                //버튼을 둥글게 처리
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text(
                "의약품 성분 풀이",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

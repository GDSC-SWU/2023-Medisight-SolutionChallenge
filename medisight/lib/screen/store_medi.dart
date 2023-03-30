import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "의약품 보관하기",
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
            // 의약품 보관 팁 버튼
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black, backgroundColor: Colors.blue,
                minimumSize: const Size(350, 140),
                //버튼을 둥글게 처리
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text(
                "시각 장애인을 위한 의약품 보관 팁",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {},
            ),
            const SizedBox(height: 30), // 여백
            // 의약품 별별 보관 버튼
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black, backgroundColor: Colors.blue,
                minimumSize: const Size(350, 140),
                //버튼을 둥글게 처리
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text(
                "꼭 확인해야 하는 의약품 별 보관 방법",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {},
            ),
            const SizedBox(height: 30), // 여백
            // 의약품 보관 주의사항 버튼
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black, backgroundColor: Colors.blue,
                minimumSize: const Size(350, 140),
                //버튼을 둥글게 처리
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text(
                "나의 안전을 위한 의약품 보관 주의사항",
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

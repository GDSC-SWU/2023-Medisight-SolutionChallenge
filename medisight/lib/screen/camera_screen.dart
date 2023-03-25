import 'package:flutter/material.dart';
import 'shoot_medi.dart';
import 'shoot_qr.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "촬영",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0.0, // 앱 바가 떠있는 효과 제거
      ),
      body: Center(
        child: Row(
          children: <Widget>[
            const SizedBox(width: 31), // 여백
            // 의약품 촬영 버튼
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.blue,
                minimumSize: const Size(160, 140),
                //버튼을 둥글게 처리
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text(
                "의약품 촬영",
                style: TextStyle(fontSize: 20),
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
            const SizedBox(width: 31), // 여백
            // 처방전 촬영 버튼
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.blue,
                minimumSize: const Size(160, 140),
                //버튼을 둥글게 처리
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text(
                "처방전 촬영",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ShootMedi()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medisight/page/search_list.dart';
import 'package:medisight/screen/map_route_screen.dart';
import 'info_screen.dart';
import 'camera_screen.dart';
import 'search_screen.dart';
import 'map_screen.dart';
import 'medi_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "메인",
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
            // 상식 버튼
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black, backgroundColor: Colors.blue,
                minimumSize: const Size(350, 140),
                //버튼을 둥글게 처리
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text(
                "상식",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => InfoScreen()),
                );
              },
            ),
            const SizedBox(height: 30), // 여백
            Row(
              children: <Widget>[
                const SizedBox(width: 31), // 여백
                // 촬영 버튼
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
                    "촬영",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CameraScreen()),
                    );
                  },
                ),
                const SizedBox(width: 31), // 여백
                // 검색 버튼
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
                    "검색",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => SearchListPage()),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 30), // 여백
            Row(
              children: <Widget>[
                const SizedBox(width: 31), // 여백
                // 지도도 버튼
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
                    "지도",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => MapScreen()),
                    );
                  },
                ),
                const SizedBox(width: 31), // 여백
                // 내 약품 버튼
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
                    "내 약품",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => MediScreen(uid: user.uid)),
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
}

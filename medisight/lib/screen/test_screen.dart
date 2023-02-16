import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  final String? data;

  const TestScreen(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "테스트 페이지",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0.0, // 앱 바가 떠있는 효과 제거
      ),
      body: Center(
        child: Text("data: $data"),
      ),
    );
  }
}

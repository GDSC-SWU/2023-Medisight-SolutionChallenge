import 'package:flutter/material.dart';

class MediScreen extends StatelessWidget {
  const MediScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "내 약품",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0.0, // 앱 바가 떠있는 효과 제거
        /*
        leading: IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        */
      ),
      body: Center(
        child: const Text("내 약품 화면"),
      ),
    );
  }
}

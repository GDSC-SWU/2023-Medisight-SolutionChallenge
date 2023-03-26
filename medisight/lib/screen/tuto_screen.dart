import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medisight/screen/disease_select.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'intro_page_1.dart';
import 'intro_page_2.dart';
import 'intro_page_3.dart';
import 'intro_page_4.dart';
import 'mypage_screen.dart';

class TutoScreen extends StatefulWidget {
  const TutoScreen({super.key});

  @override
  State<TutoScreen> createState() => _TutoScreenState();
}

class _TutoScreenState extends State<TutoScreen> {
  final PageController _controller = PageController();
  final user = FirebaseAuth.instance.currentUser!;

  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          controller: _controller,
          onPageChanged: (index) {
            setState(() {
              onLastPage = (index == 3);
            });
          },
          children: const [
            IntroPage1(),
            IntroPage2(),
            IntroPage3(),
            IntroPage4()
          ],
        ),
        Container(
            alignment: const Alignment(0, 0.9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // skip
                GestureDetector(
                  onTap: () {
                    _controller.jumpToPage(3);
                  },
                  child: const Text('건너뛰기'),
                ),

                // dot indicator
                SmoothPageIndicator(controller: _controller, count: 4),

                //next or done
                onLastPage
                    ? GestureDetector(
                        onTap: () {
                          _getRoute(user);
                        },
                        child: const Text('완료'),
                      )
                    : GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        },
                        child: const Text('다음'),
                      ),
              ],
            ))
      ],
    ));
  }

  Future<void> _getRoute(User user) async {
    final documentSnapshot =
        await FirebaseFirestore.instance.collection('user').doc(user.uid).get();
    bool subfield = documentSnapshot.data()?.containsKey('firstTuto') ?? false;

    if (subfield) {
      // 앱을 처음 사용한 경우가 아닐 때
      return Navigator.pop(
        context,
        MaterialPageRoute(builder: (_) => const MypageScreen()),
      );
    } else {
      // 앱을 처음 사용한 경우일 때
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const DiseaseSelect()),
        (route) => false,
      );
    }
  }
}

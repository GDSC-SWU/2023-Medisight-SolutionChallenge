import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../page/search_list.dart';
import 'info_screen.dart';
import 'camera_screen.dart';
import 'map_screen.dart';
import 'medi_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/medisight_logo.png',
            width: 200, height: 200),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: 350,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(
                    left: 0, top: 30, right: 34, bottom: 13),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Main Page',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '원하시는 기능을 선택해주세요.',
                      style: TextStyle(fontSize: 20, letterSpacing: 2.0),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // 상식 버튼
              DecoratedBox(
                decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      Colors.redAccent,
                      Colors.purpleAccent
                      //add more colors
                    ]),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                          color:
                              Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                          blurRadius: 5) //blur radius of shadow
                    ]),
                child: SizedBox(
                  width: 350,
                  height: 110,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      disabledForegroundColor:
                          Colors.transparent.withOpacity(0.38),
                      disabledBackgroundColor:
                          Colors.transparent.withOpacity(0.12),
                      shadowColor: Colors.transparent,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              '상식',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2.0),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '의약품 보관법, 복용법, \n성분에 대한 상식',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  letterSpacing: 2.0),
                            ),
                          ],
                        ),
                        Image.asset('assets/images/img_info.png'),
                      ],
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const InfoScreen()),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 15),
              // 촬영 버튼
              DecoratedBox(
                decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      Color.fromARGB(255, 255, 162, 0),
                      Color.fromARGB(255, 255, 122, 27)
                      //add more colors
                    ]),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                          color:
                              Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                          blurRadius: 5) //blur radius of shadow
                    ]),
                child: SizedBox(
                  width: 350,
                  height: 110,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      disabledForegroundColor:
                          Colors.transparent.withOpacity(0.38),
                      disabledBackgroundColor:
                          Colors.transparent.withOpacity(0.12),
                      shadowColor: Colors.transparent,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              '촬영',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2.0),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '소지한 의약품 정보와\n유효기간을 알 수 있는 촬영',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  letterSpacing: 2.0),
                            ),
                          ],
                        ),
                        Image.asset('assets/images/img_camera.png',
                            width: 115, height: 115),
                      ],
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CameraScreen()),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 15),
              // 검색 버튼
              DecoratedBox(
                decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      Color.fromARGB(255, 255, 130, 34),
                      Color.fromARGB(255, 253, 100, 17)
                      //add more colors
                    ]),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                          color:
                              Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                          blurRadius: 5) //blur radius of shadow
                    ]),
                child: SizedBox(
                  width: 350,
                  height: 110,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      disabledForegroundColor:
                          Colors.transparent.withOpacity(0.38),
                      disabledBackgroundColor:
                          Colors.transparent.withOpacity(0.12),
                      shadowColor: Colors.transparent,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              '검색',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2.0),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '텍스트로 직접 검색',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  letterSpacing: 2.0),
                            ),
                          ],
                        ),
                        Image.asset('assets/images/img_search.png',
                            width: 115, height: 115),
                      ],
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => SearchListPage()),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 15),
              // 지도 버튼
              DecoratedBox(
                decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      Colors.purpleAccent,
                      Colors.blueAccent,
                      //add more colors
                    ]),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                          color:
                              Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                          blurRadius: 5) //blur radius of shadow
                    ]),
                child: SizedBox(
                  width: 350,
                  height: 110,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      disabledForegroundColor:
                          Colors.transparent.withOpacity(0.38),
                      disabledBackgroundColor:
                          Colors.transparent.withOpacity(0.12),
                      shadowColor: Colors.transparent,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              '지도',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2.0),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '현재위치 기반의 약국 검색\n및 도보경로 안내',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  letterSpacing: 2.0),
                            ),
                          ],
                        ),
                        Image.asset('assets/images/img_map.png',
                            width: 115, height: 115),
                      ],
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => MapScreen()),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 15),
              // 알람 버튼
              DecoratedBox(
                decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      Colors.pinkAccent,
                      Colors.orangeAccent
                      //add more colors
                    ]),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                          color:
                              Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                          blurRadius: 5) //blur radius of shadow
                    ]),
                child: SizedBox(
                  width: 350,
                  height: 110,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      disabledForegroundColor:
                          Colors.transparent.withOpacity(0.38),
                      disabledBackgroundColor:
                          Colors.transparent.withOpacity(0.12),
                      shadowColor: Colors.transparent,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              '알람',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2.0),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '내 약품 알람 설정',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  letterSpacing: 2.0),
                            ),
                          ],
                        ),
                        Image.asset('assets/images/img_alarm.png',
                            width: 115, height: 115),
                      ],
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => MediScreen(uid: user.uid)),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

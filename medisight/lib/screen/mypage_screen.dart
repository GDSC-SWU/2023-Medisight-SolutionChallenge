import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medisight/provider/google_sign_in.dart';
import 'package:medisight/screen/theme_screen.dart';
import 'package:medisight/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import 'disease_select.dart';
import 'tuto_screen.dart';
import 'package:flutter_tts/flutter_tts.dart';

class MypageScreen extends StatefulWidget {
  const MypageScreen({super.key});

  @override
  State<MypageScreen> createState() => MypageScreenState();
}

class MypageScreenState extends State<MypageScreen> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FlutterTts tts = FlutterTts();

  var mypageList = [
    '기저질환 설정',
    '테마 설정',
    '튜토리얼',
    '로그아웃',
  ];

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    tts.speak("마이페이지");

    return Scaffold(
      appBar: AppBar(title: const Text("마이페이지")),
      body: Column(
        children: [
          Container(
            width: 500,
            height: 175,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    width: 0.5, color: Color.fromARGB(255, 216, 216, 216)),
              ),
            ),
            child: Row(
              children: [
                const SizedBox(width: 25),
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(user.photoURL!),
                ),
                const SizedBox(width: 25),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.displayName!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      user.email!,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50), //모서리를 둥글게
                            border: Border.all(color: Colors.black45, width: 3),
                          ),
                          child: const Center(
                            child: Text(
                              "천식",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Container(
                          width: 50,
                          height: 25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25), //모서리를 둥글게
                            border: Border.all(color: Colors.black45, width: 3),
                          ),
                          child: const Center(
                            child: Text(
                              "고혈압",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 500,
            height: 25,
            child: ColoredBox(color: Color.fromARGB(255, 216, 216, 216)),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: mypageList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (index == 0) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const DiseaseSelect()),
                          );
                        } else if (index == 1) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => ThemeScreen()),
                          );
                        } else if (index == 2) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const TutoScreen()),
                          );
                        } else if (index == 3) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('로그아웃'),
                              content: const Text('정말 로그아웃을 하시겠습니까?'),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    final themeMode =
                                        Provider.of<ThemeProvider>(context,
                                                listen: false)
                                            .themeMode;
                                    debugPrint('테마: $themeMode');
                                    final provider =
                                        Provider.of<GoogleSignInProvider>(
                                            context,
                                            listen: false);
                                    provider.logout();
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => MyApp(
                                                themeMode: themeMode,
                                              )),
                                      (route) => false,
                                    );
                                  },
                                  child: const Text('확인'),
                                ),
                                ElevatedButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('취소'),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      child: Container(
                        width: 500,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 0.5, color: Colors.grey),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                mypageList[index],
                                style: const TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: Icon(Icons.arrow_right),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

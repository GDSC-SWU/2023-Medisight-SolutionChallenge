import 'package:flutter/material.dart';

class MypageScreen extends StatefulWidget {
  const MypageScreen({super.key});

  @override
  State<MypageScreen> createState() => MypageScreenState();
}

class MypageScreenState extends State<MypageScreen> {
  var mypageList = [
    '기저질환 설정',
    '언어 변경',
    '튜토리얼',
    '로그아웃',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "마이페이지",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0.0, // 앱 바가 떠있는 효과 제거
      ),
      body: Column(
        children: [
          Container(
            width: 500,
            height: 175,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 0.5,
              ),
            ),
            child: Row(
              children: [
                const SizedBox(width: 25),
                SizedBox(
                  width: 120,
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100), //모서리를 둥글게
                    child: Image.asset(
                      'assets/images/img_background.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 25),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "사용자 이름",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "test@gmail.com",
                      style: TextStyle(
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
            child: ColoredBox(color: Colors.grey),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: mypageList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (index == 3) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('로그아웃'),
                              content: const Text('정말 로그아웃을 하시겠습니까?'),
                              actions: [
                                ElevatedButton(
                                  onPressed: () => Navigator.of(context)
                                      .pop(), // ***로그아웃 기능으로 변경***
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
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.5,
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
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Image.asset(
                                'assets/images/img_back_key.png',
                                width: 30,
                                height: 30,
                              ),
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

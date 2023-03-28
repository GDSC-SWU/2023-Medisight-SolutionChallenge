import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class IntroPage4 extends StatefulWidget {
  const IntroPage4({super.key});

  @override
  State<IntroPage4> createState() => _IntroPage4State();
}

class _IntroPage4State extends State<IntroPage4> {
  late YoutubePlayerController controller;

  @override
  void initState() {
    super.initState();

    const url =
        'https://www.youtube.com/watch?v=0ovJg6xN1N8&list=PLBXM_KQ8zWwoig_aJUmVs3oHT6L2c2_CL';

    controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(url)!,
        flags:
            const YoutubePlayerFlags(mute: false, loop: false, autoPlay: true));
  }

//   @override
//   Widget build(BuildContext context) => YoutubePlayerBuilder(
//         player: YoutubePlayer(
//           controller: controller,
//           aspectRatio: 9 / 16,
//         ),
//         builder: (context, player) => Scaffold(
//           body: Column(
//             children: [
//               Container(padding: const EdgeInsets.only(top: 13, bottom: 13)),
//               player
//             ],
//           ),
//         ),
//       );
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                width: size.width * 0.95,
                alignment: Alignment.center,
                padding: const EdgeInsets.only(
                    left: 10, top: 30, right: 10, bottom: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      '기타 편의 기능',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '1. 기저질환 설정\n-앱 초기설정 및 마이페이지에서 설정할 수 있습니다.\n-사용자의 기저질환을 선택하여 복용시 유의해야할 약품을 알 수 있습니다.',
                      style: TextStyle(fontSize: 18, letterSpacing: 2.0),
                    ),
                    SizedBox(height: 30),
                    Text(
                      '2. 테마 설정\n-마이페이지에서 설정할 수 있습니다.\n-기본 및 고대비 테마로 변경할 수 있습니다.',
                      style: TextStyle(fontSize: 18, letterSpacing: 2.0),
                    ),
                    SizedBox(height: 20),
                    Text(
                      '3. 어시스턴트\n-준비중입니다',
                      style: TextStyle(fontSize: 18, letterSpacing: 2.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

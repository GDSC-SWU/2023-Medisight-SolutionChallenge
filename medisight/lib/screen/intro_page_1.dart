import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class IntroPage1 extends StatefulWidget {
  const IntroPage1({super.key});

  @override
  State<IntroPage1> createState() => _IntroPage1State();
}

class _IntroPage1State extends State<IntroPage1> {
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

  // @override
  // Widget build(BuildContext context) => YoutubePlayerBuilder(
  //       player: YoutubePlayer(
  //         controller: controller,
  //         aspectRatio: 9 / 16,
  //       ),
  //       builder: (context, player) => Scaffold(
  //         body: Column(
  //           children: [
  //             Container(padding: const EdgeInsets.only(top: 13, bottom: 13)),
  //             player
  //           ],
  //         ),
  //       ),
  //     );
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
                      '촬영 페이지',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '하단에 위치한 의약품 촬영 버튼과 유효기간 촬영 버튼을 통해 소지하고 계신 의약품을 촬영할 수 있습니다',
                      style: TextStyle(fontSize: 18, letterSpacing: 2.0),
                    ),
                    SizedBox(height: 30),
                    Text(
                      '1. 의약품 촬영\n-초기 진입시 카메라 접근에 대한 권한을 허용해주세요\n-진입시 카메라가 켜집니다\n-바코드 및 큐알코드가 스캔되면 비프음과 진동이 울리고 약품 정보가 출력됩니다',
                      style: TextStyle(fontSize: 18, letterSpacing: 2.0),
                    ),
                    SizedBox(height: 20),
                    Text(
                      '2. 유효기간 촬영\n-초기 진입시 카메라 접근에 대한 권한을 허용해주세요\n-진입시 카메라가 켜집니다\n-손 위치를 안내음에따라 움직여주세요\n-완료시 유효기간이 출력됩니다',
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

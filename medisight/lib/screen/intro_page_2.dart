import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class IntroPage2 extends StatefulWidget {
  const IntroPage2({super.key});

  @override
  State<IntroPage2> createState() => _IntroPage2State();
}

class _IntroPage2State extends State<IntroPage2> {
  late YoutubePlayerController controller;

  @override
  void initState() {
    super.initState();

    const url = 'https://youtube.com/shorts/cBPyW_wQEaE?feature=share';

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
                      '지도 페이지',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '현재 위치를 기반으로 근처 약국을 검색할 수 있으며 도보 경로를 안내합니다.',
                      style: TextStyle(fontSize: 18, letterSpacing: 2.0),
                    ),
                    SizedBox(height: 30),
                    Text(
                      '1. 근처 약국 검색 결과\n- 지도 페이지 초기 진입 시, 현재 위치를 기반으로 근처 약국 약국명과 상세 주소를 보여줍니다.',
                      style: TextStyle(fontSize: 18, letterSpacing: 2.0),
                    ),
                    SizedBox(height: 20),
                    Text(
                      '2. 도보 경로 길 안내\n- 해당 약국을 선택하게 되면 바로 경로 안내를 시작합니다.\n- 페이지 상단에는 약국으로부터 남은 거리와 남은 시간을 알려줍니다.\n- 페이지의 중앙에는 현재 이동 위치와 거리를 알려주고 있으며 바로 아래 버튼에는 지도 보기 기능이 있습니다.\n- 지도 보기를 누르면 실제 지도 화면으로 넘어가게 되며, 현재 지도 상의 경로를 보여줍니다.\n- 지도 보기 화면에서 다시 돌아가고 싶다면 경로 안내 버튼을 누르면 됩니다.\n- 지도 보기 하단에는 앞으로의 경로 안내가 준비되어 있습니다.',
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

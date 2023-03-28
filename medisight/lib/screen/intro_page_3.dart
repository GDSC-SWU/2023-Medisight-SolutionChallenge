import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class IntroPage3 extends StatefulWidget {
  const IntroPage3({super.key});

  @override
  State<IntroPage3> createState() => _IntroPage3State();
}

class _IntroPage3State extends State<IntroPage3> {
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
                      '알람 페이지',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '현재 소지하고 계신 약품을 등록하여 사용기한과 특정 복용 시간을 설정해 알람을 사용할 수 있습니다.',
                      style: TextStyle(fontSize: 18, letterSpacing: 2.0),
                    ),
                    SizedBox(height: 30),
                    Text(
                      '1. 알람 추가 및 설정\n- 오른쪽 하단에 플러스 버튼을 누르면 알람을 새로 등록하실 수 있습니다.\n- 가장 처음으로는 약품명을 등록하실 수 있습니다. 그 다음으로는 해당 약품의 사용기한을 직접 기입하거나 카메라 촬영 버튼을 통해 인식하여 등록이 가능합니다.\n- 그 다음으로 알람 시간을 선택하면 시간 설정이 가능한 화면이 나와 구체적인 시간 설정이 가능합니다.\n- 이후에는 특정 요일을 선택하여 알람에 등록할 수 있습니다.\n- 이외에 알람음과 진동을 토글 버튼을 이용해 자유롭게 켜고 끌 수 있습니다.\n마지막으로 추가하기 버튼을 누르면 등록한 약품과 알람 정보가 화면에 나타납니다.',
                      style: TextStyle(fontSize: 18, letterSpacing: 2.0),
                    ),
                    SizedBox(height: 20),
                    Text(
                      '2. 알람 해제\n- 설정한 시간에 알람이 화면에 나타나면서 울리게 되는데, 알람 해제 버튼을 클릭하여 알람을 해제하세요',
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

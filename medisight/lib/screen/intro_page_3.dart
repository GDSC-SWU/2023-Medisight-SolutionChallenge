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

  @override
  Widget build(BuildContext context) => YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: controller,
          aspectRatio: 9 / 16,
        ),
        builder: (context, player) => Scaffold(
          body: Column(
            children: [
              Container(padding: const EdgeInsets.only(top: 13, bottom: 13)),
              player
            ],
          ),
        ),
      );
}

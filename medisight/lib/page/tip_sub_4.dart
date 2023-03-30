import 'package:flutter/material.dart';
import 'package:medisight/widget/grid_button_4.dart';

class TipSubPage4 extends StatefulWidget {
  const TipSubPage4({super.key});

  @override
  State<TipSubPage4> createState() => _TipSubPageState4();
}

class _TipSubPageState4 extends State<TipSubPage4> {
  @override
  Widget build(BuildContext context) => Scaffold(
          body: CustomScrollView(slivers: [
        SliverAppBar(
          expandedHeight: 200,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: const Text("의약품 성분 상식",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600)),
              background: Image.network(
                  "https://img.freepik.com/free-vector/mobile-wallpaper-with-fluid-shapes_79603-599.jpg?w=2000",
                  fit: BoxFit.cover)),
        ),
        SliverPadding(
            padding: const EdgeInsets.only(left: 28, right: 28, bottom: 28),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 32),
                          const Text(
                            "주제를 선택해주세요",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 10),
                          GridButton4()
                        ],
                      ),
                  childCount: 1),
            )),
      ]));
}

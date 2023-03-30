import 'package:flutter/material.dart';
import 'package:medisight/widget/grid_button_1.dart';

class TipSubPage1 extends StatefulWidget {
  const TipSubPage1({super.key});

  @override
  State<TipSubPage1> createState() => _TipSubPageState1();
}

class _TipSubPageState1 extends State<TipSubPage1> {
  @override
  Widget build(BuildContext context) => Scaffold(
          body: CustomScrollView(slivers: [
        SliverAppBar(
          expandedHeight: 200,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: const Text("의약품 보관 상식",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.white)),
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
                          GridButton1()
                        ],
                      ),
                  childCount: 1),
            )),
      ]));
}

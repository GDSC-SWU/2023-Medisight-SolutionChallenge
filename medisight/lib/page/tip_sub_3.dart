import 'package:flutter/material.dart';
import 'package:medisight/widget/grid_button_3.dart';

class TipSubPage3 extends StatefulWidget {
  const TipSubPage3({super.key});

  @override
  State<TipSubPage3> createState() => _TipSubPageState3();
}

class _TipSubPageState3 extends State<TipSubPage3> {
  @override
  Widget build(BuildContext context) => Scaffold(
          body: CustomScrollView(slivers: [
        SliverAppBar(
          expandedHeight: 200,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: const Text("증상별 의약품 상식",
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
                          GridButton3()
                        ],
                      ),
                  childCount: 1),
            )),
      ]));
}

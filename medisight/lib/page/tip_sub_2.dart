import 'package:flutter/material.dart';
import 'package:medisight/widget/grid_button_2.dart';

class TipSubPage2 extends StatefulWidget {
  const TipSubPage2({super.key});

  @override
  State<TipSubPage2> createState() => _TipSubPageState2();
}

class _TipSubPageState2 extends State<TipSubPage2> {
  @override
  Widget build(BuildContext context) => Scaffold(
          body: CustomScrollView(slivers: [
        SliverAppBar(
          //title: Text("Tip Sub Page"),
          expandedHeight: 200,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: const Text("의약품 복용 상식",
                  style: TextStyle(fontWeight: FontWeight.w600)),
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
                          GridButton2()
                        ],
                      ),
                  childCount: 1),
            )),
      ]));
}

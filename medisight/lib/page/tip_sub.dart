import 'package:flutter/material.dart';
import 'package:medisight/widget/grid_button.dart';

class TipSubPage extends StatefulWidget {
  const TipSubPage({super.key});

  State<TipSubPage> createState() => _TipSubPageState();
}

class _TipSubPageState extends State<TipSubPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
          body: CustomScrollView(slivers: [
        SliverAppBar(
          //title: Text("Tip Sub Page"),
          expandedHeight: 200,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text("의약품 보관 상식",
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
                          SizedBox(height: 32),
                          Text(
                            "주제를 선택해주세요",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 10),
                          GridButton()
                        ],
                      ),
                  childCount: 1),
            )),
      ]));
}

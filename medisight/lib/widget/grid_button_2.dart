import 'package:flutter/material.dart';
import 'package:medisight/page/tip_content.dart';

class GridButton2 extends StatelessWidget {
  final List<Map<String, dynamic>> gridMap = [
    {"title": "의약품 복약시간"},
    {"title": "복약시 음용수"},
    {"title": "병용금기 의약품"},
    {"title": "의약품별 상호작용 식품"},
    {"title": "기저질환에 따른 복약시 유의사항"}
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        mainAxisExtent: 110,
      ),
      itemCount: gridMap.length,
      itemBuilder: (_, index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => TipContentPage(
                    topic: "${gridMap.elementAt(index)['title']}")));
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                24.0,
              ),
              color: Colors.grey.shade300,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 18.0, top: 22.0, right: 18.0, bottom: 22.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${gridMap.elementAt(index)['title']}",
                        style: Theme.of(context).textTheme.subtitle1!.merge(
                              const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

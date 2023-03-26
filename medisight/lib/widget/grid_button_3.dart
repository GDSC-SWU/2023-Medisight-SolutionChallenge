import 'package:flutter/material.dart';
import 'package:medisight/page/tip_content.dart';

class GridButton3 extends StatelessWidget {
  final List<Map<String, dynamic>> gridMap = [
    {"title": "두통/근육통/통증"},
    {"title": "소화 불량/식체/속쓰림"},
    {"title": "감기/기침/가래"}
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

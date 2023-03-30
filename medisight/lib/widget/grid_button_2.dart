import 'package:flutter/material.dart';
import 'package:medisight/page/tip_content.dart';
import 'package:medisight/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class GridButton2 extends StatelessWidget {
  final List<Map<String, dynamic>> gridMap = [
    {"title": "의약품 복약시간"},
    {"title": "복약시 음용수"},
    {"title": "병용금기 의약품"},
    {"title": "의약품별 상호작용 식품"},
    {"title": "기저질환별 복약시 유의사항"},
    {"title": "외용약 복용법"},
    {"title": "내복약 복용법"},
    {"title": "알약 복용법"},
    {"title": "어린이 약 먹이기"},
    {"title": "임산부 약품 복용 주의사항"},
    {"title": "영양제별 복용시간대"},
  ];

  @override
  Widget build(BuildContext context) {
    final themeMode =
        Provider.of<ThemeProvider>(context, listen: false).themeMode;
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
              color: themeMode == ThemeMode.light
                  ? Colors.blue.shade50
                  : Theme.of(context).canvasColor,
              border: Border.all(
                  width: 3.0,
                  color: themeMode == ThemeMode.light
                      ? Colors.blue.shade50
                      : Color.fromARGB(255, 255, 214, 0)),
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
                              TextStyle(
                                color: themeMode == ThemeMode.light
                                    ? Colors.black
                                    : Colors.white,
                                fontSize: 16,
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

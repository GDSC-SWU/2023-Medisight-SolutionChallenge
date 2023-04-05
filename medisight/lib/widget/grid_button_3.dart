import 'package:flutter/material.dart';
import 'package:medisight/page/tip_content.dart';
import 'package:medisight/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class GridButton3 extends StatelessWidget {
  final List<Map<String, dynamic>> gridMap = [
    {"title": "해열 진통제"},
    {"title": "소염 진통제"},
    {"title": "코감기약"},
    {"title": "기침 감기약"},
    {"title": "소화제"},
    {"title": "위장약"},
    {"title": "설사약"},
    {"title": "소독약"},
    {"title": "습윤밴드"},
    {"title": "파스"},
    {"title": "비염"}
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

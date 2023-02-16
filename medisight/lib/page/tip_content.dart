import 'package:flutter/material.dart';
import 'package:medisight/widget/grid_button.dart';

class TipContentPage extends StatelessWidget {
  final Map<String, dynamic> content = {
    "title": "포장지와 함께 보관해주세요",
    "details": [
      "상비약의 경우 박스로 포장되어있다면, 박스에 의약품 정보를 확인할 수 있는 바코드가 부착되어 있으므로 최대한 박스에 넣어 같이 보관하는 것이 안전합니다.",
      "처방약의 경우 처방전 봉투에 처방된 의약품의 정보를 확인할 수 있는 바코드가 부착되어 있습니다. 꼭 처방전 봉투에 넣어 안전하게 보관해주세요.",
    ]
  };

  final String topic;
  TipContentPage({required this.topic});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text(topic, style: TextStyle(fontWeight: FontWeight.w700)),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "${content['title']}",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 32.0),
            Container(
                child: Column(
                    children: (content['details'] as List).map((detail) {
              return Column(
                children: [
                  Text(detail,
                      style: TextStyle(
                          fontSize: 18, height: 1.7, color: Colors.black87)),
                  SizedBox(height: 42.0)
                ],
              );
            }).toList())),
          ])));
}

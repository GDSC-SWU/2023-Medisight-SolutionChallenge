import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:medisight/page/search_result_content.dart';

class SearchResultPage extends StatelessWidget {
  static const List<String> selections = [
    "기본 정보",
    "제품 모양",
    "효능효과",
    "용법용량",
    "주의사항",
    "저장 방법",
    "유효기간",
    "원료 및 성분"
  ];
  final String? code; // 전처리 완료된 코드

  const SearchResultPage(this.code);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("검색 결과", style: TextStyle(fontWeight: FontWeight.w700)),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: selections.mapIndexed((i, selection) {
            return Container(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(double.infinity, 70),
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                ),
                onPressed: () {
                  print('button $i clicked.');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            SearchResultContentPage(selection, code, i)),
                  );
                },
                child: Text(
                  selection,
                  style: new TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(3),
            );
          }).toList(),
        )
        // body: ListView(
        //     padding: const EdgeInsets.all(20.0),
        //     children: List<Widget>.generate(
        //       selections.length,
        //       (i) => ElevatedButton(
        //             style: ElevatedButton.styleFrom(
        //               fixedSize: const Size(double.infinity, 70),
        //               padding: const EdgeInsets.symmetric(vertical: 10.0),
        //             ),
        //             onPressed: () {
        //               print('button $i clicked.');
        //               Navigator.push(
        //                 context,
        //                 MaterialPageRoute(
        //                     builder: (_) => SearchResultContentPage(
        //                         selections[i], code, i)),
        //               );
        //             },
        //             child: Text(
        //               selections[i],
        //               style: new TextStyle(
        //                 fontSize: 20.0,
        //                 fontWeight: FontWeight.w600,
        //               ),
        //             ),
        //           ),
        //     ).toList())
        );
  }
}

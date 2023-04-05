import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:medisight/page/search_result_content.dart';
import 'package:http/http.dart' as http;
import 'package:medisight/podo/search_result_category.dart';
import 'dart:convert';

import 'package:medisight/theme/theme_provider.dart';
import 'package:provider/provider.dart';
// import 'package:medisight/page/search_result_content.dart';

class SearchResultPage extends StatefulWidget {
  String code;

  SearchResultPage(this.code);

  @override
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
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
  String targetDiseaseStr = "";

  void checkDisease() async {
    final response = await http.get(Uri.parse(
        "http://34.64.96.217:5001/search/precautions/${widget.code}"));
    final user = FirebaseAuth.instance.currentUser!;
    CollectionReference userProduct =
        FirebaseFirestore.instance.collection("user");
    CollectionReference _diseaseRef =
        await userProduct.doc(user.uid).collection("disease");
    QuerySnapshot querySnapshot = await _diseaseRef.get();

    final diseaseList = querySnapshot.docs
        .map((doc) => (doc.data()! as Map<String, dynamic>)['symptom'])
        .toList();
    print("firestore data: ${diseaseList}");
    Map<String, dynamic> parsed = json.decode(response.body);
    String? srcStr = Precautions.fromJson(parsed).nbDocData;

    if (srcStr != null) {
      diseaseList.forEach((e) {
        if (srcStr.contains(e)) {
          targetDiseaseStr += (e + " ,") as String;
        }
      });
      if (targetDiseaseStr.length > 0)
        targetDiseaseStr =
            targetDiseaseStr.substring(0, targetDiseaseStr.length - 1);
    }

    if (targetDiseaseStr.length > 0) {
      _showMyDialog();
    }
  }

  Future<void> _showMyDialog() async {
    final themeMode =
        Provider.of<ThemeProvider>(context, listen: false).themeMode;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).canvasColor,
          title: const Text('기저질환 주의 알림',
              style: TextStyle(fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('해당 의약품은 설정하신 기저질환과 관련된 주의사항이 있습니다.'),
                SizedBox(height: 5),
                Text(targetDiseaseStr,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 72, 220))),
                SizedBox(height: 5),
                Text('의약품 사용시 유의해주세요.'),
              ],
            ),
          ),
          actions: <Widget>[
            Container(
              width: double.infinity,
              height: 50.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text("닫기", style: const TextStyle(fontSize: 20.0)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    print("+++++++++++++++++++ CODE: " + widget.code + "+++++++++++++++++++");
    checkDisease();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode =
        Provider.of<ThemeProvider>(context, listen: false).themeMode;
    return Scaffold(
        backgroundColor: themeMode == ThemeMode.light
            ? Color.fromARGB(255, 245, 245, 255)
            : Theme.of(context).canvasColor,
        appBar: AppBar(
          title: Text("검색 결과", style: TextStyle(fontWeight: FontWeight.w700)),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: selections.mapIndexed((i, selection) {
            return Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(3),
              child: DecoratedBox(
                decoration: BoxDecoration(boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: themeMode == ThemeMode.light
                          ? Color.fromRGBO(107, 134, 255, 0.5)
                          : Color.fromARGB(0, 255, 213, 0), //shadow for button
                      blurRadius: 6) //blur radius of shadow
                ]),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: themeMode == ThemeMode.light
                        ? Color.fromARGB(255, 107, 134, 255)
                        : Color.fromARGB(255, 255, 214, 0),
                    backgroundColor: Theme.of(context).canvasColor,
                    side: BorderSide(
                        color: themeMode == ThemeMode.light
                            ? Color.fromARGB(255, 107, 134, 255)
                            : Color.fromARGB(255, 255, 214, 0),
                        width: 1),
                    fixedSize: const Size(double.infinity, 70),
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                  ),
                  onPressed: () {
                    print('button $i clicked.');

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => SearchResultContentPage(
                              title: selection, code: widget.code, idx: i)),
                    );
                  },
                  child: Text(
                    selection,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medisight/screen/home_screen.dart';
import 'package:medisight/screen/mypage_screen.dart';
import 'package:medisight/theme/theme_provider.dart';
import 'package:provider/provider.dart';

import 'bottom_navi.dart';

class DiseaseSelect extends StatefulWidget {
  const DiseaseSelect({super.key});

  @override
  State<DiseaseSelect> createState() => DiseaseSelectState();
}

class DiseaseSelectState extends State<DiseaseSelect> {
  final user = FirebaseAuth.instance.currentUser!;
  CollectionReference userProduct =
      FirebaseFirestore.instance.collection('user');

  List<String> myDisease = []; // firestore의 내 질환을 화면에 출력하기 위한 리스트
  String myDiseaseStr = "";
  List<String> diseaseList = [
    '천식',
    '아토피',
    '비염',
    '혈압',
    '과민증',
    '암',
    '편두통',
    '당뇨',
    '간질환',
    '심혈관질환'
  ]; // 질병 리스트
  bool isFirst = true;
  Map<String, bool> diseaseProducts = {
    // 사용자가 새로 구성한 정보
    '천식': false,
    '아토피': false,
    '비염': false,
    '혈압': false,
    '과민증': false,
    '암': false,
    '편두통': false,
    '당뇨': false,
    '간질환': false,
    '심혈관질환': false,
  };
  Map<String, bool> diseaseProductsOrigin = {
    // firestore에 저장되어 있는 정보
    '천식': false,
    '아토피': false,
    '비염': false,
    '혈압': false,
    '과민증': false,
    '암': false,
    '편두통': false,
    '당뇨': false,
    '간질환': false,
    '심혈관질환': false,
  };

  @override
  Widget build(BuildContext context) {
    final themeMode =
        Provider.of<ThemeProvider>(context, listen: false).themeMode;
    // 질환 선택 버튼
    final List<Map> myProducts =
        List.generate(10, (index) => {"id": index, "name": diseaseList[index]})
            .toList();

    return Scaffold(
      appBar: AppBar(title: const Text("질병 및 알러지 정보 추가")),
      body: Column(
        children: [
          StreamBuilder(
            stream: userProduct.doc(user.uid).collection('disease').snapshots(),
            builder: (
              BuildContext context,
              AsyncSnapshot<QuerySnapshot> streamSnapshot,
            ) {
              if (streamSnapshot.hasData && isFirst) {
                for (var documentSnapshot in streamSnapshot.data!.docs) {
                  myDisease.add(documentSnapshot['symptom']);
                  diseaseProducts[documentSnapshot['symptom']] = true;
                  diseaseProductsOrigin[documentSnapshot['symptom']] = true;
                  myDiseaseStr += documentSnapshot['symptom'];
                  if (documentSnapshot['symptom'] !=
                      streamSnapshot.data!.docs.last['symptom']) {
                    myDiseaseStr += ", ";
                  }
                }
                return showScreen(myDiseaseStr);
              } else if (!isFirst) {
                myDiseaseStr = "";
                for (var dis in myDisease) {
                  myDiseaseStr += dis;
                  if (dis != myDisease.last) {
                    myDiseaseStr += ", ";
                  }
                }
                return showScreen(myDiseaseStr);
              }
              return const CircularProgressIndicator();
            },
          ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.only(
                  left: 10, top: 20, right: 10, bottom: 0),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 2 / 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: myProducts.length,
                itemBuilder: (BuildContext ctx, index) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeMode == ThemeMode.light
                          ? Colors.blue.shade50
                          : Theme.of(context).canvasColor,
                      fixedSize: const Size(160, 50),
                      side: BorderSide(
                          width: 1,
                          color: themeMode == ThemeMode.light
                              ? Color.fromARGB(0, 1, 1, 1)
                              : Theme.of(context).primaryColor),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      setState(() {
                        var disName = myProducts[index]["name"];
                        if (!diseaseProducts[disName]!) {
                          myDisease.add(disName);
                          print(myDisease);
                          diseaseProducts[disName] = true;
                        } else {
                          myDisease.remove(disName);
                          print(myDisease);
                          diseaseProducts[disName] = false;
                        }
                        isFirst = false;
                      });
                    },
                    child: Text(
                      myProducts[index]["name"],
                      style: const TextStyle(fontSize: 18),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget showScreen(String myDiseaseStr) {
    Size size = MediaQuery.of(context).size;
    return Align(
      child: Column(
        children: [
          SizedBox(height: 10),
          Container(
            padding:
                const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 13),
            child: Container(
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50), //모서리를 둥글게
                border:
                    Border.all(color: Theme.of(context).primaryColor, width: 2),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 20, right: 20),
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  myDiseaseStr,
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 초기화 버튼
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).canvasColor,
                  fixedSize: const Size(160, 50),
                  side: BorderSide(
                      width: 1, color: Theme.of(context).primaryColor),
                ),
                child: const Text(
                  "초기화",
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  setState(() {
                    myDisease = [];
                    for (var key in diseaseProducts.keys) {
                      diseaseProducts[key] = false;
                    }
                    isFirst = false;
                  });
                },
              ),
              SizedBox(width: 10),

              // 저장 버튼
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).canvasColor,
                  fixedSize: const Size(160, 50),
                  side: BorderSide(
                      width: 1, color: Theme.of(context).primaryColor),
                ),
                child: const Text(
                  "저장",
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  // firestore에 내 질환 저장하기
                  for (var dis in diseaseList) {
                    if (!diseaseProductsOrigin[dis]! && diseaseProducts[dis]!) {
                      userProduct
                          .doc(user.uid)
                          .collection("disease")
                          .doc(dis)
                          .set({"symptom": dis});
                    } else if (diseaseProductsOrigin[dis]! &&
                        !diseaseProducts[dis]!) {
                      userProduct
                          .doc(user.uid)
                          .collection("disease")
                          .doc(dis)
                          .delete();
                    }
                  }
                  _getRoute(user);
                },
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
              height: 1.0,
              width: size.width,
              color: Color.fromARGB(255, 197, 196, 196)),
        ],
      ),
    );
  }

  Future<void> _getRoute(User user) async {
    final documentSnapshot =
        await FirebaseFirestore.instance.collection('user').doc(user.uid).get();
    bool subfield = documentSnapshot.data()?.containsKey('firstTuto') ?? false;

    if (subfield) {
      // 앱을 처음 사용한 경우가 아닐 때
      return Navigator.pop(
        context,
        MaterialPageRoute(builder: (_) => const MypageScreen()),
      );
    } else {
      // 앱을 처음 사용한 경우일 때
      await FirebaseFirestore.instance
          .collection('user')
          .doc(user.uid)
          .set({'firstTuto': false});

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const BottomNavi(selectedIndex: 0)),
        (route) => false,
      );
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'disease_private.dart';

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
  List<String> diseaseList = ['천식', '고혈압', '유제품 알러지', '갑상선 기능 저하']; // 질병 리스트
  bool isFirst = true;
  Map<String, bool> diseaseProducts = {
    // 사용자가 새로 구성한 정보
    '천식': false,
    '고혈압': false,
    '유제품 알러지': false,
    '갑상선 기능 저하': false,
  };
  Map<String, bool> diseaseProductsOrigin = {
    // firestore에 저장되어 있는 정보
    '천식': false,
    '고혈압': false,
    '유제품 알러지': false,
    '갑상선 기능 저하': false,
  };

  @override
  Widget build(BuildContext context) {
    // 질환 선택 버튼
    final List<Map> myProducts =
        List.generate(4, (index) => {"id": index, "name": diseaseList[index]})
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "질병 및 알러지 정보 추가",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0.0, // 앱 바가 떠있는 효과 제거
      ),
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
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              itemCount: myProducts.length,
              itemBuilder: (BuildContext ctx, index) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.blue,
                    //버튼을 둥글게 처리
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
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
        ],
      ),
    );
  }

  Widget showScreen(String myDiseaseStr) {
    return Align(
      child: Column(
        children: [
          SizedBox(height: 10),
          Container(
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50), //모서리를 둥글게
              border: Border.all(color: Colors.black45, width: 3),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(20, 10),
                  //버튼을 둥글게 처리
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(20, 10),
                  //버튼을 둥글게 처리
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
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

                  Navigator.pop(
                    context,
                    MaterialPageRoute(builder: (_) => const DiseasePrivate()),
                  );
                },
              ),
              SizedBox(width: 30),
            ],
          ),
        ],
      ),
    );
  }
}

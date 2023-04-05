import 'package:flutter/material.dart';

class SearchResult {
  BasicInfo? basicInfo;
  Shape? shape;
  Efficacy? efficacy;
  Usage? usage;
  Precautions? precautions;
  Storage? storage;
  Validity? validity;
  Materials? materials;

  SearchResult(
      {this.basicInfo,
      this.shape,
      this.efficacy,
      this.usage,
      this.precautions,
      this.storage,
      this.validity,
      this.materials});

  factory SearchResult.fromJson(int idx, Map<String, dynamic> json) {
    print("fromJson: idx is $idx");
    return SearchResult(
      basicInfo: idx == 0 ? BasicInfo.fromJson(json) : null,
      shape: idx == 1 ? Shape.fromJson(json) : null,
      efficacy: idx == 2 ? Efficacy.fromJson(json) : null,
      usage: idx == 3 ? Usage.fromJson(json) : null,
      precautions: idx == 4 ? Precautions.fromJson(json) : null,
      storage: idx == 5 ? Storage.fromJson(json) : null,
      validity: idx == 6 ? Validity.fromJson(json) : null,
      materials: idx == 7 ? Materials.fromJson(json) : null,
    );
  }

  Widget prettyPrint(int idx) {
    return Container(
        padding: const EdgeInsets.all(3),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (idx == 0) ...[
            const Text("제품명",
                style: TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold, height: 1.75)),
            Text(basicInfo!.itemName!,
                style: const TextStyle(fontSize: 18.0, height: 1.75)),
            SizedBox(height: 20.0),
            const Text("제조사",
                style: TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold, height: 1.75)),
            Text(basicInfo!.entpName!,
                style: const TextStyle(fontSize: 18.0, height: 1.75))
          ] else if (idx == 1) ...[
            Text(shape!.chart!,
                style: const TextStyle(fontSize: 18.0, height: 1.75))
          ] else if (idx == 2) ...[
            Text(efficacy!.efcyQesitm!,
                style: const TextStyle(fontSize: 18.0, height: 1.75))
          ] else if (idx == 3) ...[
            Text(usage!.udDocData!,
                style: const TextStyle(fontSize: 18.0, height: 1.75))
          ] else if (idx == 4) ...[
            Text(precautions!.atpnQesitm!,
                style: const TextStyle(fontSize: 18.0, height: 1.75))
          ] else if (idx == 5) ...[
            const Text("보관 방법",
                style: TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold, height: 1.75)),
            Text(storage!.storageMethod!,
                style: const TextStyle(fontSize: 18.0, height: 1.75)),
            SizedBox(height: 20.0),
            const Text("보관 주의사항",
                style: TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold, height: 1.75)),
            Text(storage!.depositMethodQesitm!,
                style: const TextStyle(fontSize: 18.0, height: 1.75))
          ] else if (idx == 6) ...[
            Text(validity!.validTerm!,
                style: const TextStyle(fontSize: 18.0, height: 1.75))
          ] else if (idx == 7) ...[
            SizedBox(height: 20.0),
            const Text("원료성분",
                style: TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold, height: 1.75)),
            Text(materials!.materialName!,
                style: const TextStyle(fontSize: 18.0, height: 1.75)),
            const Text("성분명",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            Text(materials!.ingrName!,
                style: const TextStyle(fontSize: 18.0, height: 1.75)),
            SizedBox(height: 20.0),
            const Text("주원료성분",
                style: TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold, height: 1.75)),
            Text(materials!.mainItemIngr!,
                style: const TextStyle(fontSize: 18.0, height: 1.75)),
            SizedBox(height: 20.0),
            const Text("주원료성분 영문명",
                style: TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold, height: 1.75)),
            Text(materials!.mainIngrEng!,
                style: const TextStyle(fontSize: 18.0, height: 1.75))
          ] else ...[
            const Text("의약품 정보의 인덱스가 유효하지 않습니다.")
          ]
        ]));
  }
}

class BasicInfo {
  String itemSeq;
  String? itemName;
  String? entpName;
  String? itemPermitDate;
  String? etcOtcCode;
  String? barCode;
  String? reexamTarget;
  String? reexamDate;
  String? ediCode;
  String? permitKindName;
  String? entpNo;
  String? makeMaterialFlag;
  String? indutyType;
  String? cancelDate;
  String? cancelName;
  String? changeDate;
  String? gbnName;
  String? itemEngName;
  String? entpEngName;

  BasicInfo({required this.itemSeq, this.itemName, this.entpName});

  factory BasicInfo.fromJson(Map<String, dynamic> json) {
    return BasicInfo(
        itemSeq: json["itemSeq"],
        itemName: json["itemName"],
        entpName: json["entpName"]);
  }
}

class Shape {
  String itemSeq;
  String? chart;

  Shape({required this.itemSeq, this.chart});

  factory Shape.fromJson(Map<String, dynamic> json) {
    return Shape(itemSeq: json["itemSeq"], chart: json["chart"]);
  }
}

class Efficacy {
  String itemSeq;
  String? efcyQesitm;

  Efficacy({required this.itemSeq, this.efcyQesitm});

  factory Efficacy.fromJson(Map<String, dynamic> json) {
    return Efficacy(itemSeq: json["itemSeq"], efcyQesitm: json["efcyQesitm"]);
  }
}

class Usage {
  String itemSeq;
  String? udDocData;

  Usage({required this.itemSeq, this.udDocData});

  factory Usage.fromJson(Map<String, dynamic> json) {
    return Usage(itemSeq: json["itemSeq"], udDocData: json["udDocData"]);
  }
}

class Precautions {
  String itemSeq;
  String? nbDocData;
  String? atpnQesitm;

  Precautions({required this.itemSeq, this.nbDocData, this.atpnQesitm});

  factory Precautions.fromJson(Map<String, dynamic> json) {
    return Precautions(
        itemSeq: json["itemSeq"],
        nbDocData: json["nbDocData"],
        atpnQesitm: json["atpnQesitm"]);
  }
}

class Storage {
  String itemSeq;
  String? storageMethod;
  String? depositMethodQesitm;

  Storage(
      {required this.itemSeq, this.storageMethod, this.depositMethodQesitm});

  factory Storage.fromJson(Map<String, dynamic> json) {
    return Storage(
        itemSeq: json["itemSeq"],
        storageMethod: json["storageMethod"],
        depositMethodQesitm: json["depositMethodQesitm"]);
  }
}

class Validity {
  String itemSeq;
  String? validTerm;

  Validity({required this.itemSeq, this.validTerm});

  factory Validity.fromJson(Map<String, dynamic> json) {
    return Validity(itemSeq: json["itemSeq"], validTerm: json["validTerm"]);
  }
}

class Materials {
  String itemSeq;
  String? materialName;
  String? ingrName;
  String? mainItemIngr;
  String? mainIngrEng;

  Materials(
      {required this.itemSeq,
      this.materialName,
      this.ingrName,
      this.mainItemIngr,
      this.mainIngrEng});

  factory Materials.fromJson(Map<String, dynamic> json) {
    return Materials(
        itemSeq: json["itemSeq"],
        materialName: json["materialName"],
        ingrName: json["ingrName"],
        mainItemIngr: json["mainItemIngr"],
        mainIngrEng: json["mainIngrEng"]);
  }
}

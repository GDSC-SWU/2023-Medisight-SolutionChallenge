import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medisight/page/search_result.dart';

class Medicine {
  String itemSeq;
  String itemName;
  String entpName;

  Medicine(
      {required this.itemSeq, required this.itemName, required this.entpName});

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
        itemSeq: json["itemSeq"] as String,
        itemName: json["itemName"] as String,
        entpName: json["entpName"] as String);
  }
}

class Services {
  static const String url = 'http://34.64.96.217:5001/search/code/';

  static Future<List<Medicine>> getData(String keyword) async {
    try {
      if (keyword.length < 2) return [];

      final response = await http.get(Uri.parse(url + keyword));
      if (response.statusCode == 200) {
        List<Medicine> list = parseData(response.body);
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<Medicine> parseData(String responseBody) {
    final parsed = json.decode(responseBody) as Map<String, dynamic>;
    final data = parsed["data"];
    return data.map<Medicine>((json) => Medicine.fromJson(json)).toList();
  }
}

class Debouncer {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class SearchListPage extends StatefulWidget {
  SearchListPage() : super();

  final String title = "의약품 검색";

  @override
  SearchListPageState createState() => SearchListPageState();
}

class SearchListPageState extends State<SearchListPage> {
  final _debouncer = Debouncer(milliseconds: 500);
  String keyword = "";
  List<Medicine> listData = [];

  void search() {
    print(keyword); // debug
    Services.getData(keyword).then((response) {
      setState(() {
        listData = response;
      });
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(15.0),
              hintText: '이곳에 약품명을 입력해주세요',
            ),
            onChanged: (string) {
              keyword = string;
              if (keyword.length > 1) {
                _debouncer.run(() {
                  search();
                });
              } else {
                setState(() {
                  listData = [];
                });
              }
            },
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: listData.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                SearchResultPage(listData[index].itemSeq),
                          ));
                    },
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            listData[index].itemName,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            listData[index].entpName,
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

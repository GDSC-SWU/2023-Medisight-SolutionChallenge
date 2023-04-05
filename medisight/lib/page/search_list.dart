import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medisight/page/search_result.dart';

import 'package:medisight/theme/theme_provider.dart';
import 'package:provider/provider.dart';

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
    Size size = MediaQuery.of(context).size;
    final themeMode =
        Provider.of<ThemeProvider>(context, listen: false).themeMode;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Container(
            width: size.width * 0.93,
            height: 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: themeMode == ThemeMode.light
                  ? Color(0xffffffff)
                  : Theme.of(context).canvasColor,
              border: Border.all(
                  width: 2.0,
                  color: themeMode == ThemeMode.light
                      ? Color.fromARGB(0, 255, 213, 0)
                      : Theme.of(context).primaryColor),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(80, 0, 0, 0),
                  offset: Offset(0, 3),
                  blurRadius: 5,
                ),
              ],
            ),
            child: TextField(
              style: TextStyle(
                fontSize: 14,
                color: themeMode == ThemeMode.light
                    ? Color(0xff000000)
                    : Colors.white,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(0, 0, 187, 212)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(0, 0, 187, 212)),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.search,
                    color: themeMode == ThemeMode.light
                        ? Color(0xff000000)
                        : Theme.of(context).primaryColor,
                  ),
                  onPressed: () {},
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                hintText: "약품명을 입력해주세요.",
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: Color(0xffcbd0d6),
                ),
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
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: listData.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  color: Theme.of(context).canvasColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      // border color
                      color: Theme.of(context).primaryColor,

                      // border thickness
                      width: 1,
                    ),
                  ),
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
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            listData[index].itemName,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0,
                                color: themeMode == ThemeMode.light
                                    ? Color.fromARGB(255, 0, 0, 0)
                                    : Color.fromARGB(255, 255, 214, 0)),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            listData[index].entpName,
                            style: TextStyle(
                                fontSize: 14.0,
                                color: themeMode == ThemeMode.light
                                    ? Colors.grey
                                    : Colors.white),
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

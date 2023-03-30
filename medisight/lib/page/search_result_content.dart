import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medisight/podo/search_result_category.dart';
import 'dart:convert';

class SearchResultService {
  static const List<String> endpoints = [
    "http://34.64.96.217:5001/search/basicInfo/",
    "http://34.64.96.217:5001/search/shape/",
    "http://34.64.96.217:5001/search/efficacy/",
    "http://34.64.96.217:5001/search/usage/",
    "http://34.64.96.217:5001/search/precautions/",
    "http://34.64.96.217:5001/search/storage/",
    "http://34.64.96.217:5001/search/validity/",
    "http://34.64.96.217:5001/search/materials/"
  ];

  static Future<SearchResult> getData(int idx, String code) async {
    try {
      final response = await http.get(Uri.parse(endpoints[idx] + code));
      print(
          "SearchResultService: GET ${endpoints[idx] + code} got ${response.statusCode}.");
      if (response.statusCode == 200) {
        SearchResult searchResult = parseData(idx, response.body);
        return searchResult;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static SearchResult parseData(int idx, String responseBody) {
    final parsed = json.decode(responseBody) as Map<String, dynamic>;
    return SearchResult.fromJson(idx, parsed);
  }
}

class SearchResultContentPage extends StatefulWidget {
  final String title, code;
  final int idx;

  const SearchResultContentPage(
      {required this.title, required this.code, required this.idx});

  @override
  _SearchResultContentPageState createState() =>
      _SearchResultContentPageState();
}

class _SearchResultContentPageState extends State<SearchResultContentPage> {
  SearchResult searchResult = SearchResult();

  @override
  void initState() {
    super.initState();
    SearchResultService.getData(widget.idx, widget.code).then((response) {
      setState(() {
        searchResult = response;
      });
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text(widget.title,
            style: const TextStyle(fontWeight: FontWeight.w700)),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FutureBuilder(
              future: SearchResultService.getData(widget.idx, widget.code),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: Text("데이터를 불러오고 있습니다..."));
                } else {
                  searchResult = snapshot.data;
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        searchResult.prettyPrint(widget.idx),
                        const SizedBox(height: 30),
                        Container(
                            height: 1.0,
                            width: 350,
                            color: Color.fromARGB(255, 197, 196, 196)),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            minimumSize: Size(350, 60),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            '검색결과 목록으로 돌아가기',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  );
                }
              })));
}

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:medisight/screen/map_route_screen.dart';
import 'package:medisight/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class Pharmacy {
  String endPoiId;
  String name;
  String telNo;
  String lat;
  String lng;
  String address;

  Pharmacy(
      {required this.endPoiId,
      required this.name,
      required this.telNo,
      required this.lat,
      required this.lng,
      required this.address});

  factory Pharmacy.fromJson(Map<String, dynamic> json) {
    return Pharmacy(
        endPoiId: json["endPoiId"] as String,
        name: json["name"] as String,
        telNo: json["telNo"] as String,
        lat: json["noorLat"] as String,
        lng: json["noorLon"] as String,
        address: json["address"] as String);
  }
}

class Services {
  static const String url = 'http://34.64.96.217:5001/map/place?keyword=약국';

  static Future<List<Pharmacy>> getData(double lat, double lng) async {
    try {
      print(url + "&lat=$lat&lng=$lng");
      final response = await http.get(Uri.parse(url + "&lat=$lat&lng=$lng"));
      if (response.statusCode == 200) {
        List<Pharmacy> list = parseData(response.body);
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<Pharmacy> parseData(String responseBody) {
    final parsed = json.decode(responseBody) as Map<String, dynamic>;
    final data = parsed["result"];
    return data.map<Pharmacy>((json) => Pharmacy.fromJson(json)).toList();
  }
}

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  double lat = 0.0;
  double lng = 0.0;
  Location location = new Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;

  List<Pharmacy> listData = [];

  @override
  void initState() {
    super.initState();
    _locateMe();
  }

  _locateMe() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    await location.getLocation().then((res) {
      setState(() {
        lat = res.latitude!;
        lng = res.longitude!;
      });
    });

    Services.getData(lat, lng).then((response) {
      setState(() {
        listData = response;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeMode =
        Provider.of<ThemeProvider>(context, listen: false).themeMode;
    return Scaffold(
      appBar: AppBar(
        title: Text("약국 검색결과"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 10),
            DecoratedBox(
              decoration: BoxDecoration(
                  color: themeMode == ThemeMode.light
                      ? Colors.white
                      : Theme.of(context).canvasColor,
                  border: Border.all(
                    width: 3,
                    color: themeMode == ThemeMode.light
                        ? Color.fromARGB(0, 255, 213, 0)
                        : Color.fromARGB(255, 255, 214, 0),
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.2), //shadow for button
                        blurRadius: 5) //blur radius of shadow
                  ]),
              child: Container(
                padding: const EdgeInsets.only(
                    left: 30, top: 0, right: 16, bottom: 20),
                width: 350,
                height: 230,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '약국 검색결과',
                          style: TextStyle(
                              color: themeMode == ThemeMode.light
                                  ? Colors.black
                                  : Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              height: 1.75),
                        ),
                        Image.asset('assets/images/img_pharmacy.png',
                            width: 140, height: 120),
                      ],
                    ),
                    Text(
                      '아래의 검색결과는\n거리순으로 정렬되어있습니다.\n경로 안내를 받으실 약국을 선택하세요.',
                      style: TextStyle(
                          color: themeMode == ThemeMode.light
                              ? Colors.black
                              : Colors.white,
                          fontSize: 16,
                          height: 1.75),
                    ),
                  ],
                ),
              ),
            ),
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
                        color: Theme.of(context).primaryColor,
                        width: 1,
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MapRouteScreen(
                                  listData[index].name,
                                  lat,
                                  lng,
                                  double.parse(listData[index].lat),
                                  double.parse(listData[index].lng)),
                            ));
                      },
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              listData[index].name,
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
                              listData[index].address,
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
      ),
    );
  }
}

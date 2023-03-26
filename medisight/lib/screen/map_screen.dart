import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:medisight/screen/map_route_screen.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text("약국 검색결과"),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: // Center(
                  //   child: Text("Lat: $lat, Lng: $lng"),
                  // ),
                  ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemCount: listData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MapRouteScreen(
                                  lat,
                                  lng,
                                  double.parse(listData[index].lat),
                                  double.parse(listData[index].lng)),
                            ));
                      },
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              listData[index].name,
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              listData[index].address,
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
            // Container(
            //   width: double.infinity,
            //   child: ElevatedButton(
            //     child: Text("Locate Me"),
            //     onPressed: () => _locateMe(),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

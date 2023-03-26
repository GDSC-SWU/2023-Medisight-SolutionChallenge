import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'dart:convert';
import 'package:medisight/podo/route_info.dart';
import 'package:medisight/podo/route_map_info.dart';

import 'package:medisight/widget/route_instruction_widget.dart';
import 'package:medisight/widget/route_map_widget.dart';

class RouteInfoService {
  static const String url = 'http://34.64.96.217:5001/map/route';

  static Future<RouteInfo> getData(
      double lat, double lng, double destLat, double destLng) async {
    try {
      final response = await http.post(Uri.parse(
          url + "?lat=$lat&lng=$lng&destLat=$destLat&destLng=$destLng"));
      print("++++++++++++URL: " +
          url +
          "?lat=$lat&lng=$lng&destLat=$destLat&destLng=$destLng");
      print("++++++++++++GOT ${response.statusCode}");
      if (response.statusCode == 200) {
        RouteInfo routeInfo = parseData(response.body);
        return routeInfo;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static RouteInfo parseData(String responseBody) {
    final parsed = json.decode(responseBody) as Map<String, dynamic>;
    return RouteInfo.fromJson(parsed);
  }
}

class RouteMapInfoService {
  static const String url = 'http://34.64.96.217:5001/map/route/coords';

  static Future<RouteMapInfo> getData(
      double lat, double lng, double destLat, double destLng) async {
    try {
      final response = await http.post(Uri.parse(
          url + "?lat=$lat&lng=$lng&destLat=$destLat&destLng=$destLng"));
      print("++++++++++++URL: " +
          url +
          "?lat=$lat&lng=$lng&destLat=$destLat&destLng=$destLng");
      print("++++++++++++GOT ${response.statusCode}");
      if (response.statusCode == 200) {
        RouteMapInfo routeMapInfo = parseData(response.body);
        return routeMapInfo;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static RouteMapInfo parseData(String responseBody) {
    final parsed = json.decode(responseBody) as Map<String, dynamic>;
    return RouteMapInfo.fromJson(parsed);
  }
}

class MapRouteScreen extends StatefulWidget {
  double lat;
  double lng;
  double destLat;
  double destLng;

  MapRouteScreen(this.lat, this.lng, this.destLat, this.destLng);

  @override
  _MapRouteScreenState createState() => _MapRouteScreenState();
}

class _MapRouteScreenState extends State<MapRouteScreen> {
  Location location = new Location();
  bool instructionView = true;
  late FlutterTts tts = FlutterTts();
  final assetsAudioPlayer = AssetsAudioPlayer();

  late Timer gpsTimer;
  late Timer audioTimer;

  RouteInfo prevRouteInfo = RouteInfo(
      totalDistance: 0,
      totalTime: 0,
      instNow: Instruction(remain: 0, description: "", turnType: 0),
      instNext: Instruction(remain: 0, description: "", turnType: 0),
      instNextNext: Instruction(remain: 0, description: "", turnType: 0));

  RouteInfo routeInfo = RouteInfo(
      totalDistance: 0,
      totalTime: 0,
      instNow: Instruction(remain: 0, description: "", turnType: 0),
      instNext: Instruction(remain: 0, description: "", turnType: 0),
      instNextNext: Instruction(remain: 0, description: "", turnType: 0));

  RouteMapInfo routeMapInfo = RouteMapInfo(
      points: Points(coordList: [Coord(lat: 0.0, lng: 0.0)]),
      lineStrings: LineStrings(path: [
        LineStringPath(coordList: [Coord(lat: 0.0, lng: 0.0)])
      ]));

  changeViewFlag() {
    setState(() {
      instructionView = !instructionView;
    });
  }

  // 5초마다 음성 안내
  speakInstruction() {
    // 인스트럭션에 변화가 없으면 안내하지 않음
    if (prevRouteInfo.instNow.description != routeInfo.instNow.description) {
      tts.speak(routeInfo.instNow.description);
      prevRouteInfo = routeInfo;
    }
  }

  // 하나의 task가 끝나면 띵동소리
  bool instructionChanged() {
    return (prevRouteInfo.instNext.description !=
            routeInfo.instNext.description) ||
        (prevRouteInfo.instNextNext.description !=
            routeInfo.instNextNext.description) ||
        (prevRouteInfo.instNow.description == "");
  }

  @override
  void initState() {
    super.initState();

    // gps location update interval
    gpsTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      location.getLocation().then((res) {
        setState(() {
          widget.lat = res.latitude!;
          widget.lng = res.longitude!;
        });
      });

      RouteInfoService.getData(
              widget.lat, widget.lng, widget.destLat, widget.destLng)
          .then((response) {
        setState(() {
          routeInfo = response;
        });
      });
      RouteMapInfoService.getData(
              widget.lat, widget.lng, widget.destLat, widget.destLng)
          .then((response) {
        setState(() {
          routeMapInfo = response;
        });
      });
      print("${widget.lat} ${widget.lng}");
    });

    // audio instruction interval
    audioTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (instructionChanged()) {
        assetsAudioPlayer
            .open(
          Audio("assets/audios/route_changed.mp3"),
        )
            .then((_) {
          Future.delayed(const Duration(milliseconds: 1300), () {
            speakInstruction();
          });
        });
      } else {
        speakInstruction();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    gpsTimer.cancel();
    audioTimer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("약국 경로안내"),
        ),
        body: instructionView
            ? RouteInstructionWidget(
                changeViewFlag: changeViewFlag, routeInfo: routeInfo)
            : RouteMapWidget(
                changeViewFlag: changeViewFlag,
                routeMapInfo: routeMapInfo,
                userLat: widget.lat,
                userLng: widget.lng,
                destLat: widget.destLat,
                destLng: widget.destLng));
  }
}

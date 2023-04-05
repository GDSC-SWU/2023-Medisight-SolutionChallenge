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
  String name;
  double lat;
  double lng;
  double destLat;
  double destLng;

  MapRouteScreen(this.name, this.lat, this.lng, this.destLat, this.destLng);

  @override
  _MapRouteScreenState createState() => _MapRouteScreenState();
}

class _MapRouteScreenState extends State<MapRouteScreen> {
  Location location = new Location();
  bool instructionView = true;
  late FlutterTts tts = FlutterTts();
  final assetsAudioPlayer = AssetsAudioPlayer();

  late StreamSubscription<LocationData> locationSubscription;

  Timer? gpsTimer;
  Timer? audioTimer;

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

  // 일정 초 간격으로 음성 안내
  speakInstruction(int remain, int turnType) async {
    await tts.speak(routeInfo.instNow.description);
    if (remain <= 10) {
      await tts.speak("$remain 미터 앞, ${getDirection(turnType)}입니다.");
    }
  }

  String getDirection(int turnType) {
    switch (turnType) {
      case 12:
      case 212:
        return "좌회전";
      case 13:
      case 213:
        return "우회전";
      case 17:
      case 215:
        return "10시 방향 좌회전";
      case 18:
      case 216:
        return "2시 방향 우회전";
      case 16:
      case 214:
        return "8시 방향 좌회전";
      case 19:
      case 217:
        return "4시 방향 우회전";
      case 14:
        return "유턴";
      case 201:
        return "목적지";
      default:
        return "직진";
    }
  }

  @override
  void initState() {
    super.initState();
    tts.awaitSpeakCompletion(true);

    locationSubscription =
        location.onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        widget.lat = currentLocation.latitude!;
        widget.lng = currentLocation.longitude!;
      });
    });

    // 최초 데이터 받아오기
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
      tts.speak("경로 안내를 시작합니다.").then((_) {
        speakInstruction(
            routeInfo.instNext.remain, routeInfo.instNext.turnType);
      });
    });

    if (gpsTimer == null) {
      // gps location update interval
      gpsTimer = Timer.periodic(const Duration(seconds: 31), (timer) {
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
      });

      // audio instruction
      int remain = routeInfo.instNext.remain;
      int turnType = routeInfo.instNext.turnType;
      // 다음 task까지 10m 이하일 경우 띵동소리
      if (remain <= 10) {
        assetsAudioPlayer
            .open(
          Audio("assets/audios/route_changed.mp3"),
        )
            .then((_) {
          Future.delayed(const Duration(milliseconds: 1300), () {
            speakInstruction(remain, turnType);
          });
        });
      } else {
        speakInstruction(remain, turnType);
      }
      // print("${widget.lat} ${widget.lng}");

    }

    if (audioTimer == null) {
      audioTimer = Timer.periodic(const Duration(seconds: 21), (timer) {
        // audio instruction
        int remain = routeInfo.instNext.remain;
        int turnType = routeInfo.instNext.turnType;
        // 다음 task까지 10m 이하일 경우 띵동소리
        if (remain <= 10) {
          assetsAudioPlayer
              .open(
            Audio("assets/audios/route_changed.mp3"),
          )
              .then((_) {
            Future.delayed(const Duration(milliseconds: 1300), () {
              speakInstruction(remain, turnType);
            });
          });
        } else {
          speakInstruction(remain, turnType);
        }
        // print("${widget.lat} ${widget.lng}");
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    gpsTimer?.cancel();
    audioTimer?.cancel();
    locationSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("약국 경로안내"),
        ),
        body: RouteInstructionWidget(
            name: widget.name,
            routeInfo: routeInfo,
            routeMapInfo: routeMapInfo,
            lat: widget.lat,
            lng: widget.lng,
            destLat: widget.destLat,
            destLng: widget.destLng));
  }
}

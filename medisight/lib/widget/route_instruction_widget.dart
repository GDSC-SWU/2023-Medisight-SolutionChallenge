import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:medisight/podo/route_info.dart';
import 'package:medisight/podo/route_map_info.dart';
import 'package:medisight/theme/theme_provider.dart';
import 'dart:math' as math;

import 'package:medisight/widget/route_map_widget.dart';
import 'package:provider/provider.dart';

class RouteInstructionWidget extends StatefulWidget {
  String name;
  RouteInfo routeInfo;
  RouteMapInfo routeMapInfo;
  double lat;
  double lng;
  double destLat;
  double destLng;
  RouteInstructionWidget(
      {Key? key,
      required this.name,
      required this.routeInfo,
      required this.routeMapInfo,
      required this.lat,
      required this.lng,
      required this.destLat,
      required this.destLng})
      : super(key: key);

  @override
  State<RouteInstructionWidget> createState() => _RouteInstructionWidgetState();
}

class _RouteInstructionWidgetState extends State<RouteInstructionWidget> {
  Widget getIcon(themeMode) {
    int turnType = widget.routeInfo.instNow.turnType;
    switch (turnType) {
      case 12:
      case 212:
        return Icon(Icons.turn_left,
            color: themeMode == ThemeMode.light
                ? Colors.grey.shade900
                : Colors.white,
            size: 200.0);
      case 13:
      case 213:
        return Icon(Icons.turn_right,
            color: themeMode == ThemeMode.light
                ? Colors.grey.shade900
                : Colors.white,
            size: 200.0);
      case 17:
      case 215:
        return Icon(Icons.turn_slight_left,
            color: themeMode == ThemeMode.light
                ? Colors.grey.shade900
                : Colors.white,
            size: 200.0);
      case 18:
      case 216:
        return Icon(Icons.turn_slight_right,
            color: themeMode == ThemeMode.light
                ? Colors.grey.shade900
                : Colors.white,
            size: 200.0);
      case 16:
      case 214:
        return Transform.rotate(
          angle: -math.pi / 3,
          child: Icon(Icons.straight,
              color: themeMode == ThemeMode.light
                  ? Colors.grey.shade900
                  : Colors.white,
              size: 200.0),
        );
      case 19:
      case 217:
        return Transform.rotate(
          angle: math.pi / 3,
          child: Icon(Icons.straight,
              color: themeMode == ThemeMode.light
                  ? Colors.grey.shade900
                  : Colors.white,
              size: 200.0),
        );
      case 14:
        return Icon(Icons.u_turn_left,
            color: themeMode == ThemeMode.light
                ? Colors.grey.shade900
                : Colors.white,
            size: 200.0);
      case 201:
        return Icon(Icons.local_pharmacy,
            color: themeMode == ThemeMode.light
                ? Colors.grey.shade900
                : Colors.white,
            size: 200.0);
      default:
        return Icon(Icons.straight,
            color: themeMode == ThemeMode.light
                ? Colors.grey.shade900
                : Colors.white,
            size: 200.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeMode =
        Provider.of<ThemeProvider>(context, listen: false).themeMode;
    return Scaffold(
      body: Container(
        // width: double.infinity,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(60, 28, 28, 28),
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(18)),
              child: FittedBox(
                fit: BoxFit.fitWidth, // 가로 길이에 맞추도록 설정.
                child: Column(
                  children: [
                    Text(widget.name,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center, // 주 축 기준 중앙
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 20.0),
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: Theme.of(context).primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(18)),
                          child: SizedBox(
                            child: Text(
                                "남은 거리 ${widget.routeInfo.totalDistance}m",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Theme.of(context).primaryColor)),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 20.0),
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: Theme.of(context).primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(18)),
                          child: SizedBox(
                            child: Text(
                              "남은 시간 ${widget.routeInfo.totalTime}초",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    getIcon(themeMode),
                    Text("${widget.routeInfo.instNow.description}",
                        style: const TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold))
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 60.0,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeMode == ThemeMode.light
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).canvasColor,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          width: 2,
                          color: themeMode == ThemeMode.light
                              ? const Color.fromARGB(0, 255, 255, 255)
                              : Theme.of(context).primaryColor),
                      // border radius
                      borderRadius: BorderRadius.circular(16)),
                ),
                icon: Icon(Icons.room,
                    color: themeMode == ThemeMode.light
                        ? Colors.white
                        : Theme.of(context).primaryColor),
                label: Text(
                  "지도 보기",
                  style: TextStyle(
                      fontSize: 20.0,
                      color: themeMode == ThemeMode.light
                          ? Colors.white
                          : Theme.of(context).primaryColor),
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RouteMapWidget(
                        routeMapInfo: widget.routeMapInfo,
                        userLat: widget.lat,
                        userLng: widget.lng,
                        destLat: widget.destLat,
                        destLng: widget.destLng),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: themeMode == ThemeMode.light
                          ? const Color.fromARGB(0, 255, 213, 0)
                          : const Color.fromARGB(255, 255, 214, 0),
                      width: 2.0),
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  color: themeMode == ThemeMode.light
                      ? Colors.blue.shade50
                      : Theme.of(context).canvasColor),
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
              child: Text(
                  "${widget.routeInfo.instNext.remain}m 앞 ${widget.routeInfo.instNext.description}",
                  style: const TextStyle(fontWeight: FontWeight.w600)),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: themeMode == ThemeMode.light
                          ? const Color.fromARGB(0, 255, 213, 0)
                          : const Color.fromARGB(255, 255, 214, 0),
                      width: 2.0),
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  color: themeMode == ThemeMode.light
                      ? Colors.blue.shade50
                      : Theme.of(context).canvasColor),
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
              child: Text(
                  "${widget.routeInfo.instNextNext.remain}m 앞 ${widget.routeInfo.instNextNext.description}",
                  style: const TextStyle(fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }
}

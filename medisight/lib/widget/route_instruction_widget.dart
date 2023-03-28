import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:medisight/podo/route_info.dart';
import 'package:medisight/podo/route_map_info.dart';
import 'dart:math' as math;

import 'package:medisight/widget/route_map_widget.dart';

class RouteInstructionWidget extends StatefulWidget {
  RouteInfo routeInfo;
  RouteMapInfo routeMapInfo;
  double lat;
  double lng;
  double destLat;
  double destLng;
  RouteInstructionWidget(
      {Key? key,
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
  Widget getIcon() {
    int turnType = widget.routeInfo.instNow.turnType;
    switch (turnType) {
      case 12:
      case 212:
        return Icon(Icons.turn_left, color: Colors.grey.shade900, size: 200.0);
      case 13:
      case 213:
        return Icon(Icons.turn_right, color: Colors.grey.shade900, size: 200.0);
      case 17:
      case 215:
        return Icon(Icons.turn_slight_left,
            color: Colors.grey.shade900, size: 200.0);
      case 18:
      case 216:
        return Icon(Icons.turn_slight_right,
            color: Colors.grey.shade900, size: 200.0);
      case 16:
      case 214:
        return Transform.rotate(
          angle: -math.pi / 3,
          child: Icon(Icons.straight, color: Colors.grey.shade900, size: 200.0),
        );
      case 19:
      case 217:
        return Transform.rotate(
          angle: math.pi / 3,
          child: Icon(Icons.straight, color: Colors.grey.shade900, size: 200.0),
        );
      case 14:
        return Icon(Icons.u_turn_left,
            color: Colors.grey.shade900, size: 200.0);
      case 201:
        return Icon(Icons.local_pharmacy,
            color: Colors.grey.shade900, size: 200.0);
      default:
        return Icon(Icons.straight, color: Colors.grey.shade900, size: 200.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, // 주 축 기준 중앙
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 20.0),
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: Colors.blue.shade600,
                        ),
                        borderRadius: BorderRadius.circular(18)),
                    child: SizedBox(
                      child: Text("남은 거리 ${widget.routeInfo.totalDistance}m",
                          style: const TextStyle(
                              fontSize: 16.0, color: Colors.blue)),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 20.0),
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: Colors.blue.shade600,
                        ),
                        borderRadius: BorderRadius.circular(18)),
                    child: SizedBox(
                      child: Text(
                        "남은 시간 ${widget.routeInfo.totalTime}초",
                        style:
                            const TextStyle(fontSize: 16.0, color: Colors.blue),
                      ),
                    ),
                  )
                ]),
            Expanded(
                child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  getIcon(),
                  Text("${widget.routeInfo.instNow.description}",
                      style: const TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold))
                ],
              ),
            )),
            Container(
              width: double.infinity,
              height: 50.0,
              child: ElevatedButton.icon(
                icon: Icon(Icons.room),
                label: Text("지도 보기", style: const TextStyle(fontSize: 20.0)),
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
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  color: Colors.grey.shade300),
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
              child: Text(
                  "${widget.routeInfo.instNext.remain}m 앞 ${widget.routeInfo.instNext.description}",
                  style: const TextStyle(fontWeight: FontWeight.w600)),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  color: Colors.grey.shade300),
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

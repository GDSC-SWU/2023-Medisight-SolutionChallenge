import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medisight/podo/route_map_info.dart';

class RouteMapWidget extends StatefulWidget {
  RouteMapInfo routeMapInfo;
  double userLat;
  double userLng;
  double destLat;
  double destLng;

  RouteMapWidget(
      {Key? key,
      required this.routeMapInfo,
      required this.userLat,
      required this.userLng,
      required this.destLat,
      required this.destLng})
      : super(key: key);

  @override
  State<RouteMapWidget> createState() => _RouteMapWidgetState();
}

class _RouteMapWidgetState extends State<RouteMapWidget> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Polyline> _polyline = {};
  late CameraPosition _kGooglePlex;

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      zoom: 19.151926040649414);

  @override
  void initState() {
    super.initState();

    _kGooglePlex = CameraPosition(
      target: LatLng(widget.userLat, widget.userLng),
      zoom: 16.4746,
    );

    _polyline.add(Polyline(
        polylineId: PolylineId('path'),
        points: convertLineData(widget.routeMapInfo.lineStrings),
        color: Colors.blue,
        startCap: Cap.roundCap,
        endCap: Cap.buttCap));
  }

  List<LatLng> convertLineData(LineStrings rawData) {
    List<LatLng> newData = [];

    rawData.path.forEach(
        (e) => e.coordList.forEach((e) => newData.add(LatLng(e.lat, e.lng))));

    return newData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        markers: {
          Marker(
            markerId: MarkerId("origin"),
            position: LatLng(widget.userLat, widget.userLng),
          ),
          Marker(
            markerId: MarkerId("destination"),
            position: LatLng(widget.destLat, widget.destLng),
          )
        },
        polylines: _polyline,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pop(context),
        label: Text('경로안내 보기', style: const TextStyle(fontSize: 20.0)),
        icon: Icon(Icons.route),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

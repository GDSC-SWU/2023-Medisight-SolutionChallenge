import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medisight/podo/route_map_info.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:medisight/theme/theme_provider.dart';

import 'dart:ui' as ui;
import 'dart:typed_data';

import 'package:provider/provider.dart';

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

class _RouteMapWidgetState extends State<RouteMapWidget>
    with WidgetsBindingObserver {
  Completer<GoogleMapController> _controller = Completer();
  Set<Polyline> _polyline = {};
  late CameraPosition _kGooglePlex;
  late Uint8List originIcon;
  late Uint8List destinationIcon;

  late String _darkMapStyle;
  late String _lightMapStyle;
  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      zoom: 19.151926040649414);

  @override
  void initState() {
    super.initState();
    final themeMode =
        Provider.of<ThemeProvider>(context, listen: false).themeMode;
    _kGooglePlex = CameraPosition(
      target: LatLng(widget.userLat, widget.userLng),
      zoom: 16.4746,
    );

    setCustomMapPin();

    _polyline.add(Polyline(
        polylineId: PolylineId('path'),
        points: convertLineData(widget.routeMapInfo.lineStrings),
        color: themeMode == ThemeMode.light
            ? Colors.blue
            : Color.fromARGB(255, 255, 72, 220),
        startCap: Cap.roundCap,
        endCap: Cap.buttCap));

    WidgetsBinding.instance.addObserver(this);
    _loadMapStyles();
  }

  Future<void> setCustomMapPin() async {
    originIcon =
        await getBytesFromAsset('assets/images/marker_origin.png', 130);
    destinationIcon =
        await getBytesFromAsset('assets/images/marker_destination.png', 130);
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future _loadMapStyles() async {
    _darkMapStyle = await rootBundle.loadString('assets/mapstyle/dark.json');
    _lightMapStyle = await rootBundle.loadString('assets/mapstyle/light.json');
  }

  Future _setMapStyle() async {
    final controller = await _controller.future;
    final themeMode =
        Provider.of<ThemeProvider>(context, listen: false).themeMode;
    if (themeMode == ThemeMode.dark)
      controller.setMapStyle(_darkMapStyle);
    else
      controller.setMapStyle(_lightMapStyle);
  }

  @override
  void didChangePlatformBrightness() {
    setState(() {
      _setMapStyle();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  List<LatLng> convertLineData(LineStrings rawData) {
    List<LatLng> newData = [];

    rawData.path.forEach(
        (e) => e.coordList.forEach((e) => newData.add(LatLng(e.lat, e.lng))));

    return newData;
  }

  @override
  Widget build(BuildContext context) {
    final themeMode =
        Provider.of<ThemeProvider>(context, listen: false).themeMode;
    return Scaffold(
      body: FutureBuilder(
        future: setCustomMapPin(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              markers: {
                Marker(
                    markerId: MarkerId("origin"),
                    draggable: false,
                    icon: BitmapDescriptor.fromBytes(originIcon),
                    position: LatLng(widget.userLat, widget.userLng)),
                Marker(
                    markerId: MarkerId("destination"),
                    draggable: false,
                    icon: BitmapDescriptor.fromBytes(destinationIcon),
                    position: LatLng(widget.destLat, widget.destLng))
              },
              polylines: _polyline,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                _setMapStyle();
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
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

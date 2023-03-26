class Coord {
  double lat;
  double lng;

  Coord({required this.lat, required this.lng});

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(lat: json["lat"] as double, lng: json["lng"] as double);
  }
}

class Points {
  List<Coord> coordList;

  Points({required this.coordList});

  factory Points.fromJson(List<dynamic> json) {
    return Points(
        coordList: json.map<Coord>((e) => Coord.fromJson(e)).toList());
  }
}

class LineStringPath {
  List<Coord> coordList;

  LineStringPath({required this.coordList});

  factory LineStringPath.fromJson(Map<String, dynamic> json) {
    return LineStringPath(
        coordList: json["path"].map<Coord>((e) => Coord.fromJson(e)).toList());
  }
}

class LineStrings {
  List<LineStringPath> path = <LineStringPath>[];

  LineStrings({required this.path});

  factory LineStrings.fromJson(List<dynamic> json) {
    return LineStrings(
        path: json
            .map<LineStringPath>((e) => LineStringPath.fromJson(e))
            .toList());
  }
}

class RouteMapInfo {
  Points points;
  LineStrings lineStrings;

  RouteMapInfo({required this.points, required this.lineStrings});

  factory RouteMapInfo.fromJson(Map<String, dynamic> json) {
    return RouteMapInfo(
        points: Points.fromJson(json["points"]),
        lineStrings: LineStrings.fromJson(json["linestrings"]));
  }
}

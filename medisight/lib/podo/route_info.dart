class Instruction {
  int remain;
  String description;
  int turnType;

  Instruction(
      {required this.remain,
      required this.description,
      required this.turnType});

  factory Instruction.fromJson(Map<String, dynamic> json) {
    return Instruction(
        remain: json["remain"] as int,
        description: json["description"] as String,
        turnType: json["turnType"] as int);
  }
}

class RouteInfo {
  int totalDistance;
  int totalTime;
  Instruction instNow;
  Instruction instNext;
  Instruction instNextNext;

  RouteInfo(
      {required this.totalDistance,
      required this.totalTime,
      required this.instNow,
      required this.instNext,
      required this.instNextNext});

  factory RouteInfo.fromJson(Map<String, dynamic> json) {
    return RouteInfo(
        totalDistance: json["totalDistance"] as int,
        totalTime: json["totalTime"] as int,
        instNow: Instruction.fromJson(json["inst_now"]),
        instNext: Instruction.fromJson(json["inst_next"]),
        instNextNext: Instruction.fromJson(json["inst_next_next"]));
  }
}

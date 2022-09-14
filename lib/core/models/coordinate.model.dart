class CoordinateModel {
  final int x;
  final int y;

  CoordinateModel({
    required this.x,
    required this.y,
  });

  factory CoordinateModel.fromJson(Map<String, dynamic> json) {
    return CoordinateModel(
      x: json["x"],
      y: json["y"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "x": x,
      "y": y,
    };
  }
}

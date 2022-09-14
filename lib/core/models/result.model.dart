import 'package:webspark_test/core/models/index.dart';

class Result {
  final List<CoordinateModel> steps;
  final String path;

  Result({
    required this.steps,
    required this.path,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      steps: List<CoordinateModel>.from(json["steps"].map(
        (x) => CoordinateModel.fromJson(x),
      )),
      path: json["path"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "steps": List<dynamic>.from(steps.map((x) => x.toJson())),
      "path": path,
    };
  }
}

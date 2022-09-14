import 'package:webspark_test/core/models/index.dart';

class CalculationPostModel {
  final String id;
  final Result result;

  CalculationPostModel({
    required this.id,
    required this.result,
  });

  factory CalculationPostModel.fromJson(Map<String, dynamic> json) {
    return CalculationPostModel(
      id: json["id"],
      result: Result.fromJson(json["result"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "result": result.toJson(),
    };
  }

  static List<CalculationPostModel> fromJsonList(List json) {
    return json
        .map((e) => CalculationPostModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static List<Map<String, dynamic>> toJsonList(
      List<CalculationPostModel> list) {
    return list.map((e) => e.toJson()).toList();
  }
}

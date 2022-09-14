import 'package:webspark_test/core/models/index.dart';

class CalculationGetModel {
  final String id;
  final List<String> field;
  final CoordinateModel start;
  final CoordinateModel end;

  CalculationGetModel({
    required this.id,
    required this.field,
    required this.start,
    required this.end,
  });

  factory CalculationGetModel.fromJson(Map<String, dynamic> json) {
    return CalculationGetModel(
      id: json["id"],
      field: List<String>.from(json["field"].map((x) => x)),
      start: CoordinateModel?.fromJson(json["start"]),
      end: CoordinateModel?.fromJson(json["end"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "field": List<dynamic>.from(field.map((x) => x)),
      "start": start.toJson(),
      "end": end.toJson(),
    };
  }

  static List<CalculationGetModel> fromJsonList(List json) {
    return json
        .map((e) => CalculationGetModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static List<Map<String, dynamic>> toJsonList(List<CalculationGetModel> list) {
    return list.map((e) => e.toJson()).toList();
  }
}

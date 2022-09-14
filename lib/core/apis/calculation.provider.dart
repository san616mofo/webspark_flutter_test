import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:webspark_test/core/models/index.dart';

class CalculationProvider {
  static const baseURL = "https://flutter.webspark.dev";
  static const calculationEndpoint = "$baseURL/flutter/api";

  static Future<List<CalculationGetModel>> getCalculationResults(
    String url,
  ) async {
    try {
      Response response = await Dio().get(url);
      debugPrint(response.data.toString());
      List<CalculationGetModel> result =
          CalculationGetModel.fromJsonList(response.data["data"]);
      return result;
    } on DioError catch (e) {
      debugPrint("Status code: ${e.response?.statusCode.toString()}");
      throw Exception("Failed to load calculation results.");
    }
  }

  static Future<List<CalculationPostModel>> postCalculationResult() async {
    try {
      Response response = await Dio().post(calculationEndpoint, data: [
        {
          "id": UniqueKey().hashCode.toString(),
          "result": {
            "steps": [
              {"x": 0, "y": 0}
            ],
            "path": "string"
          }
        }
      ]);
      debugPrint(response.toString());
      List<CalculationPostModel> result =
          CalculationPostModel.fromJsonList(response.data["data"]);
      return result;
    } on DioError catch (e) {
      debugPrint("Status code: ${e.response?.statusCode.toString()}");
      throw Exception("Failed to create new calculation result.");
    }
  }
}

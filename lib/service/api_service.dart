import 'package:dio/dio.dart';
import 'package:restapi/models/api_model.dart';

class ApiService {
  static String pathUrl = "http://192.168.43.107:5000/api/products";
  static Future<List<ApiModel>> getData() async {
    Response res = await Dio().get(pathUrl);
    return (res.data as List).map((e) => ApiModel.fromJson(e)).toList();
  }

  static Future<List<ApiModel>> deleteData(String id) async {
    Response res = await Dio().delete(pathUrl + "/$id");
    return (res.data as List).map((e) => ApiModel.fromJson(e)).toList();
  }

  static Future<List<ApiModel>> postData(
    String id, {
    String? name,
    String? description,
    double? price,
  }) async {
    var data = {
      'id': id,
      'name': name ?? 'null',
      'description': description ?? 'null',
      'price': price ?? 0
    };
    Response res = await Dio().post(
      pathUrl,
      data: data,
      options: Options(
        headers: {'Content-type': "application/json; charset=UTF-8"},
      ),
    );
    return (res.data as List).map((e) => ApiModel.fromJson(e)).toList();
  }
}

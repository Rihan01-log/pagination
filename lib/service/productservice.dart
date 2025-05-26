import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:task/model/productmodel.dart';

class Productservice {
  final baseUrl = 'https://dummyjson.com/products';
  Dio dio = Dio();

  Future<List<Product>> fetchData({int limit = 10, int skip = 0}) async {
    try {
      final response = await dio.get(
        baseUrl,
        queryParameters: {"limit": limit, 'skip': skip},
      );
      if (response.statusCode == 200) {
        Productmodel data = Productmodel.fromJson(response.data);
        log(data.product.toString());
        return data.product;
      }
    } on DioException catch (e) {
      log('data not reached in service $e');
    }
    return [];
  }
}

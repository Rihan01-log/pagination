import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:task/model/productmodel.dart';
import 'package:task/service/productservice.dart';

class Productcont extends ChangeNotifier {
  Productservice servie = Productservice();
  List<Product> products = [];
  int limit = 10;
  int skip = 0;
  bool isLoading = false;
  bool hasMore = true;

  Future<void> getData() async {
    if (isLoading || !hasMore) return;
    isLoading = true;
    notifyListeners();

    try {
      List<Product> newData = await servie.fetchData(
        limit: limit,
        skip: skip,
      );

      if (newData.isNotEmpty) {
        products.addAll(newData);
        skip+=limit;
      }else{
        hasMore=false;
      }
      log('Data fetched');
    } catch (e) {
      log('Error: $e');
    }
    isLoading = false;
    notifyListeners();
  }
}

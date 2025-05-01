import 'package:flutter/material.dart';
import 'package:sippy_assessment/core/utils/service_locator.dart';
import 'package:sippy_assessment/features/products/domain/entities/product.dart';
import 'package:sippy_assessment/features/products/domain/usecases/get_products.dart';

final usecase = getIt<GetProducts>();

class ProductsList with ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Product> get products => _products;

  int get size => _products.length;

  Future<void> fetchProducts() async {
    try {
      _isLoading = true;
      notifyListeners();
      _products = await usecase.call();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      // Handle error
    }
  }
}


import 'package:get/get.dart';

import '../core/api_service.dart';
import '../models/product_model.dart'; 

class ProductController extends GetxController {
  var products = <Product>[].obs;
  var isLoading = true.obs;

  void fetchProductsByCategory(String category) async {
    try {
      isLoading(true);
      products.value = await ApiService.fetchProductsByCategory(category);
    } finally {
      isLoading(false);
    }
  }
}

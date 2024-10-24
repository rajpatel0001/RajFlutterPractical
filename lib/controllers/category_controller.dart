import 'package:get/get.dart';

import '../core/api_service.dart'; 

class CategoryController extends GetxController {
  var categories = [].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  void fetchCategories() async {
    try {
      isLoading(true);
      categories.value = await ApiService.fetchCategories();
    } finally {
      isLoading(false);
    }
  }
}

import 'package:flutter_practical/models/product_model.dart'; 
import 'package:flutter_practical/views/product_screen.dart';
import 'package:get/get.dart';

import '../views/category_screen.dart';
import '../views/login_screen.dart';
import '../views/product_detail_screen.dart'; 

class Routes {
  static const login = '/login';
  static const home = '/home';
  static const productDetail = '/productDetail';
    static const products = '/products';

}

class AppPages {
  static final pages = [
    GetPage(name: Routes.login, page: () => LoginScreen()),
    GetPage(name: Routes.home, page: () => CategoryScreen()),
    GetPage(name: Routes.productDetail, page: () => ProductDetailScreen()),
    GetPage(name: Routes.products, page: () => ProductScreen()),
  ];
}

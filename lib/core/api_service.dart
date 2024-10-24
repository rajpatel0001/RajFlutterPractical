import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/product_model.dart'; 

class ApiService {
  static Future<List<String>> fetchCategories() async {
    final response = await http.get(Uri.parse('https://fakestoreapi.com/products/categories'));
    if (response.statusCode == 200) {
      return List<String>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load categories');
    }
  }

  static Future<List<Product>> fetchProductsByCategory(String category) async {
    final response = await http.get(Uri.parse('https://fakestoreapi.com/products/category/$category'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Product.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  static Future<Product> fetchProductDetails(int productId) async {
    final response = await http.get(Uri.parse('https://fakestoreapi.com/products/$productId'));
    if (response.statusCode == 200) {
      return Product.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load product details');
    }
  }

  // Add functions for cart operations like add, remove, update here...
}

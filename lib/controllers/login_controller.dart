import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_practical/views/category_screen.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  var isLoggedIn = false.obs;

  Future<void> login(String username, String password) async {
    if (username.isEmpty) {
      Get.snackbar('Error!!', 'Please enter username');
    } else if (password.isEmpty) {
      Get.snackbar('Error!!', 'Please enter password');
    } else {
      final url = Uri.parse('https://fakestoreapi.com/auth/login');
      final response = await http
          .post(url, body: {"username": username, "password": password});

      if (response.statusCode == 200) {
        // Handle successful login
        var data = json.decode(response.body);
        isLoggedIn.value = true;
        Get.to(CategoryScreen());
      } else {
        if (response.body.isNotEmpty) {
          Get.snackbar('Error!!', response.body);
        } else {
          Get.snackbar('Error!!', 'Something went wrong please try again');
        }
      }
    }
  }
}

import 'package:flutter_practical/core/routes.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthService extends GetxController {
  RxBool isLogged = false.obs;

  Future<bool> login(String username, String password) async {
    if (username.isEmpty) {
      Get.snackbar('Error!', "please enter username");
      return false;
    } else if (password.isEmpty) {
      Get.snackbar('Error!', "please enter password");
      return false;
    } else {
// Fake Store API Login call
      final response = await http.post(
        Uri.parse('https://fakestoreapi.com/auth/login'),
        body: {"username": username, "password": password},
      );

      if (response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('token', response.body); // Save token locally
        isLogged.value = true;
        Get.offAllNamed(Routes.home);
        return true;
      } else {
        Get.snackbar('Error!', response.body);
        return false;
      }
    }
  }

  // Check if user is logged in by verifying token presence in SharedPreferences
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null && token.isNotEmpty) {
      isLogged.value = true;
      return true;
    } else {
      isLogged.value = false;
      return false;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token'); // Clear token
    isLogged.value = false;
    Get.offAllNamed(Routes.login);
  }
}

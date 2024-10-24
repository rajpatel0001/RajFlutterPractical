import 'package:flutter/material.dart';
import 'package:get/get.dart'; 

import 'core/auth_service.dart';
import 'core/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final authService = Get.put(AuthService());
  bool isLoggedIn = await authService.isLoggedIn(); // Check if token exists

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  MyApp({required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: isLoggedIn ? Routes.home : Routes.login,
      getPages: AppPages.pages,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

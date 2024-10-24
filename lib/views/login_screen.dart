import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/auth_service.dart'; 

class LoginScreen extends StatelessWidget {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService authService = Get.find<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 50,),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                         style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            foregroundColor: Colors.white),
              onPressed: () {
                authService.login(
                  _usernameController.text,
                  _passwordController.text,
                );
              },
              child: Text('Login'),
            ),)
          ],
        ),
      ),
    );
  }
}

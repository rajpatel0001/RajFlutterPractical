import 'package:flutter/material.dart';
import 'package:flutter_practical/core/routes.dart';
import 'package:get/get.dart';

import '../controllers/category_controller.dart';
import '../core/auth_service.dart'; 

class CategoryScreen extends StatelessWidget {
  final CategoryController categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => AuthService().logout(),
          ),
        ],
      ),
      body: Obx(() {
        if (categoryController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: categoryController.categories.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.cyanAccent.shade100,
                child: ListTile(
                  title: Text(categoryController.categories[index].toString().toUpperCase() , style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold, ),),
                  onTap: () {
                    Get.toNamed(Routes.products, arguments: categoryController.categories[index]);
                  },
                ),
              ).marginSymmetric(horizontal: 10);
            },
          );
        }
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_practical/views/cart_screen.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import '../controllers/product_controller.dart';
import '../models/product_model.dart';
import 'product_detail_screen.dart';

class ProductScreen extends StatelessWidget {
  final String category = Get.arguments;
  final ProductController productController = Get.put(ProductController());
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    productController.fetchProductsByCategory(category);

    return Scaffold(
      appBar: AppBar(
        title: Text('Products - $category'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Get.to(() => CartScreen());
            },
          ),
        ],
      ),
      body: Obx(() {
        if (productController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: productController.products.length,
            itemBuilder: (context, index) {
              Product product = productController.products[index];
              return Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white, // Background color of the card
                  borderRadius: BorderRadius.circular(16), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Shadow color
                      spreadRadius: 5, // How much the shadow spreads
                      blurRadius: 7, // Blur radius for a softer shadow
                      offset: Offset(
                          0, 3), // Shadow position (horizontal, vertical)
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => ProductDetailScreen(), arguments: product);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(product.image,
                          height: 100,
                          width: double.infinity,
                          fit: BoxFit.contain),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(product.title,
                            maxLines: 2, overflow: TextOverflow.ellipsis),
                      ),
                      Text('\$${product.price}',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            foregroundColor: Colors.white),
                        onPressed: () => cartController.addToCart(product),
                        child: Text('Add to Cart'),
                      ).marginOnly(left: 5),
                    ],
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}

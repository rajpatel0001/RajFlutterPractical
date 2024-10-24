import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart'; 

class CartScreen extends StatelessWidget {
  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return Center(child: Text('No items in the cart.'));
        } else {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartController.cartItems.length,
                  itemBuilder: (context, index) {
                    var item = cartController.cartItems[index];
                    return ListTile(
                      leading: Image.network(item.product.image, width: 50, height: 50),
                      title: Text(item.product.title),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Quantity: ${item.quantity}'),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () async {
                                  if (item.quantity > 1) {
                                    cartController.updateCartQuantity(item.product.id, item.quantity - 1);
                                  } else {
                                    cartController.removeFromCart(item.product.id);
                                  }
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () async {
                                  cartController.updateCartQuantity(item.product.id, item.quantity + 1);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('\$${(item.product.price * item.quantity).toStringAsFixed(2)}'),
                          TextButton(
                            onPressed: () async {
                              cartController.removeFromCart(item.product.id);
                            },
                            child: Text(
                              'Remove',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Total: \$${cartController.totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Handle checkout functionality here
                  },
                  child: Text('Checkout'),
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}

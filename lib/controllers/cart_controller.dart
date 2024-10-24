import 'package:get/get.dart';

import '../models/cart_item_model.dart';
import '../models/product_model.dart'; 

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs;

  void addToCart(Product product) {
    var index = cartItems.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      cartItems[index].quantity++;
    } else {
      cartItems.add(CartItem(product: product, quantity: 1));
    }
  }

  void removeFromCart(int productId) {
    cartItems.removeWhere((item) => item.product.id == productId);
  }

  void updateCartQuantity(int productId, int quantity) {
    var index = cartItems.indexWhere((item) => item.product.id == productId);
    if (index != -1) {
      cartItems[index].quantity = quantity;
    }
  }

  double get totalPrice => cartItems.fold(0, (sum, item) => sum + item.product.price * item.quantity);
}

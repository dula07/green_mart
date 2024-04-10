// ignore_for_file: avoid_print

import 'package:get/get.dart';
import '../models/cart_model.dart';

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs;

  void addItem(CartItem item) {
    try {
      CartItem? existingItem = cartItems.firstWhereOrNull((element) => element.id == item.id);
      if (existingItem != null) {
        existingItem.incrementQuantity();
      } else {
        cartItems.add(item);
      }
    } catch (e) {
      // Handle the error, possibly showing an error message to the user
      print("Error adding item to cart: $e");
    }
    update();
  }

  void removeItem(String itemId) {
    cartItems.removeWhere((item) => item.id == itemId);
    update();
  }

  void clearCart() {
    cartItems.clear();
    update();
  }

  double get totalPrice => cartItems.fold(0, (sum, item) => sum + item.price * item.quantity);
}

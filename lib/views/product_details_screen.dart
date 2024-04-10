import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import '../models/cart_model.dart';
import '../models/product_model.dart';
import '../routes/routes.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();

    return Scaffold(
      floatingActionButton: Stack(
        alignment: Alignment.topRight,
        children: [
          FloatingActionButton(
            backgroundColor: const Color(0xFF124819),
            child: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            onPressed: () {
              Get.offAndToNamed(Routes.getCartScreen());
            },
          ),
          Obx(() {
            int cartItemCount = cartController.cartItems.length;
            return cartItemCount > 0
                ? Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '$cartItemCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                : const SizedBox.shrink();
          }),
        ],
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Get.height * 0.15),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[
                  Color(0xFFC2F3A8),
                  Color(0xFFC1E0C8),
                ],
              ),
            ),
            child: SizedBox(
              height: Get.height * 0.15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      Get.offAndToNamed(Routes.getProductsScreen());
                    },
                    child: SizedBox(
                      width: Get.width * 0.1,
                      child: Image.asset(
                        "assets/images/back_icon.png",
                      ),
                    ),
                  ),
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF124819),
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.1,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.white,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  product.imgUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  product.name,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'LKR ${product.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF50B221),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Category: ${product.productCategory}",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  product.description,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: const Color(0xFF124819),
                      backgroundColor: const Color(0xFFBEF1A2),
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      final cartController = Get.find<CartController>();
                      CartItem productItem = CartItem(
                        id: product.id,
                        name: product.name,
                        price: product.price,
                      );

                      bool isItemInCart = cartController.cartItems.any((item) => item.id == productItem.id);
                      if (isItemInCart) {
                        Get.snackbar(
                          'Item already in cart',
                          '${product.name} is already added to your cart.',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.redAccent,
                          colorText: Colors.white,
                        );
                      } else {
                        cartController.addItem(productItem);
                        Get.snackbar(
                          'Item added to cart',
                          '${product.name} has been added to your cart.',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                        );
                      }
                    },
                    child: const Text(
                      "Add to Cart",
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: const Color(0xFFFFFFFF),
                      backgroundColor: const Color(0xFF124819),
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            surfaceTintColor: Colors.white,
                            backgroundColor: Colors.white,
                            title: const Text("Purchase Item"),
                            content: const Text("Are you sure you want to purchase?"),
                            actions: <Widget>[
                              TextButton(
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: const Text(
                                  "Purchase",
                                  style: TextStyle(
                                    color: Colors.green,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();

                                  Get.snackbar(
                                    'Purchase Successfull!',
                                    "You have successfully purchased the selected item",
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.green,
                                    colorText: Colors.white,
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text(
                      "Buy Now",
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

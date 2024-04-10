import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import '../routes/routes.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Get.height * 0.15),
        child: AppBar(
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
                      Get.offAndToNamed(Routes.getHomeScreen());
                    },
                    child: SizedBox(
                      width: Get.width * 0.1,
                      child: Image.asset(
                        "assets/images/back_icon.png",
                      ),
                    ),
                  ),
                  const Text(
                    "Shopping Cart",
                    style: TextStyle(
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
      body: Container(
        margin: const EdgeInsets.only(top: 8),
        child: Obx(() {
          if (cartController.cartItems.isEmpty) {
            return const Center(child: Text("Your cart is empty"));
          }
          return RawScrollbar(
            thumbVisibility: true,
            thickness: 8.0,
            radius: const Radius.circular(10.0),
            thumbColor: Colors.green,
            child: ListView.builder(
              itemCount: cartController.cartItems.length,
              itemBuilder: (context, index) {
                final item = cartController.cartItems[index];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.shopping_cart),
                    title: Text(item.name),
                    subtitle: Text('Quantity: ${item.quantity}'),
                    trailing: Wrap(
                      spacing: 12,
                      children: <Widget>[
                        Text('LKR. ${item.price.toStringAsFixed(2)}'),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  surfaceTintColor: Colors.white,
                                  backgroundColor: Colors.white,
                                  title: const Text("Remove Item"),
                                  content: Text("Are you sure you want to remove ${item.name} from your cart?"),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text(
                                        "Cancel",
                                        style: TextStyle(
                                          color: Colors.green,
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text(
                                        "Remove",
                                        style: TextStyle(
                                          color: Colors.red,
                                        ),
                                      ),
                                      onPressed: () {
                                        cartController.removeItem(item.id);
                                        Navigator.of(context).pop();

                                        Get.snackbar(
                                          'Successfully Removed',
                                          "You have successfully removed the selected item",
                                          snackPosition: SnackPosition.BOTTOM,
                                          backgroundColor: Colors.grey,
                                          colorText: Colors.white,
                                        );
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: const Icon(
                            Icons.remove_circle_outline,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }),
      ),
      bottomNavigationBar: Obx(() => Container(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total:',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'LKR. ${cartController.totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
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
                      if (cartController.cartItems.isEmpty) {
                        Get.snackbar(
                          'No items to purchase',
                          'Please add items to the cart before make a purchase.',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              surfaceTintColor: Colors.white,
                              backgroundColor: Colors.white,
                              title: const Text("Confirm Payment"),
                              content: const Text("Are you sure you want to purchase all these items?"),
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
                                      'Purchase Successfull',
                                      'Your purchase has been successfull.',
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.green,
                                      colorText: Colors.white,
                                    );

                                    cartController.clearCart();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text(
                      'Purchase Now',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

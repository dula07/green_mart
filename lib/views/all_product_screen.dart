import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import '../controllers/firestore_controller.dart';
import '../models/product_model.dart';
import '../routes/routes.dart';
import 'product_details_screen.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({super.key});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  final FireStoreController fireStoreController = Get.find();

  @override
  void initState() {
    super.initState();
    fireStoreController.fetchProducts();
  }

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
                    "All Products",
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
        child: FutureBuilder<List<Product>>(
          future: fireStoreController.fetchProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              // Ensure there's data and it's not empty
              final productsList = snapshot.data!;
              return RawScrollbar(
                thumbVisibility: true,
                thickness: 8.0,
                radius: const Radius.circular(10.0),
                thumbColor: Colors.green,
                child: ListView.builder(
                  itemCount: productsList.length,
                  itemBuilder: (context, index) {
                    final product = productsList[index];
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
                        leading: Image.network(product.imgUrl, width: 100, fit: BoxFit.cover),
                        title: Text(product.name),
                        subtitle: Text(product.description),
                        trailing: Text('LKR. ${product.price.toStringAsFixed(2)}'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailScreen(product: product),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            } else {
              // Show a text message when no products are found
              return const Center(child: Text('No products found'));
            }
          },
        ),
      ),
    );
  }
}

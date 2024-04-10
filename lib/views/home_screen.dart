import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import '../routes/routes.dart';
import 'category_products_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.find<CartController>();
    return Scaffold(
      floatingActionButton: Stack(
        alignment: Alignment.topRight,
        children: [
          FloatingActionButton(
            heroTag: 'uniqueTag01',
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
                  SizedBox(
                    width: Get.width * 0.65,
                    child: Image.asset(
                      "assets/images/long_logo.png",
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                    },
                    child: SizedBox(
                      width: Get.width * 0.1,
                      child: Image.asset(
                        "assets/images/log_out_icon.png",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GestureDetector(
                onTap: () {
                  Get.offAndToNamed(Routes.getSearchScreen());
                },
                child: TextFormField(
                  enabled: false,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(
                      Icons.search,
                      color: Color(0xFF124819),
                    ),
                    hintText: 'Search Products',
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(
                        color: Color(0xFF124819),
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                )),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.25,
                  child: Row(
                    children: [
                      SizedBox(
                        width: Get.width * 0.45,
                        child: CategoryCard(
                          categoryName: "Foods & Drinks",
                          categoryImage: "assets/images/dish.png",
                          onTap: () {
                            Get.to(() => const CategoryProductsScreen(category: "Foods & Drinks"));
                          },
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.45,
                        child: CategoryCard(
                          categoryName: "Books & Stationary",
                          categoryImage: "assets/images/book.png",
                          onTap: () {
                            Get.to(() => const CategoryProductsScreen(category: "Books & Stationary"));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.25,
                  child: Row(
                    children: [
                      SizedBox(
                        width: Get.width * 0.45,
                        child: CategoryCard(
                          categoryName: "T-shirts & Bangles",
                          categoryImage: "assets/images/tshirt.png",
                          onTap: () {
                            Get.to(() => const CategoryProductsScreen(category: "T-shirts & Bangles"));
                          },
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.45,
                        child: CategoryCard(
                          categoryName: "Other",
                          categoryImage: "assets/images/more.png",
                          onTap: () {
                            Get.to(() => const CategoryProductsScreen(category: "Other"));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String categoryName;
  final String categoryImage;
  final VoidCallback onTap;

  const CategoryCard({
    Key? key,
    required this.categoryName,
    required this.categoryImage,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        margin: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              height: Get.height * 0.1,
              child: Image.asset(categoryImage),
            ),
            Text(
              categoryName,
              style: const TextStyle(
                color: Color(0xFF124819),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

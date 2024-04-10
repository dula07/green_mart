// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/firestore_controller.dart';
import '../models/product_model.dart';
import '../routes/routes.dart';

class CategoryProductsScreen extends StatefulWidget {
  final String category;

  const CategoryProductsScreen({Key? key, required this.category}) : super(key: key);

  @override
  _CategoryProductsScreenState createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  final FireStoreController fireStoreController = Get.find();

  Future<List<Product>> fetchCategoryProducts() async {
    final allProducts = await fireStoreController.fetchProducts();
    return allProducts.where((product) => product.productCategory == widget.category).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
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
                      Get.offAndToNamed(Routes.getHomeScreen());
                    },
                    child: SizedBox(
                      width: Get.width * 0.1,
                      child: Image.asset(
                        "assets/images/back_icon.png",
                      ),
                    ),
                  ),
                  Text(
                    widget.category,
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
      body: Container(
        margin: const EdgeInsets.only(top: 8),
        child: FutureBuilder<List<Product>>(
          future: fetchCategoryProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              final products = snapshot.data!;
              return RawScrollbar(
                thumbVisibility: true,
                thickness: 8.0,
                radius: const Radius.circular(10.0),
                thumbColor: Colors.green,
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Column(
                      children: [
                        Container(
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
                            onTap: () {},
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            } else {
              return const Center(child: Text('No products found in this category.'));
            }
          },
        ),
      ),
    );
  }
}

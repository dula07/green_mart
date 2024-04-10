// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/product_search_bar_controller.dart';
import '../models/product_model.dart';
import '../routes/routes.dart';
import 'product_details_screen.dart';

class ProductSearchBarScreen extends StatefulWidget {
  @override
  _ProductSearchBarScreenState createState() => _ProductSearchBarScreenState();
}

class _ProductSearchBarScreenState extends State<ProductSearchBarScreen> {
  final ProductsSearchBarController productsSearchController = Get.find<ProductsSearchBarController>();
  String query = '';
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
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
                children: [
                  InkWell(
                    onTap: () {
                      Get.offAndToNamed(Routes.getHomeScreen());
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      width: Get.width * 0.1,
                      child: Image.asset(
                        "assets/images/back_icon.png",
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: textEditingController,
                      onChanged: (value) {
                        setState(() {
                          query = value;
                          textEditingController.text = value;
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: 'Search products',
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.black),
                      ),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        query = '';
                        textEditingController.clear();
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      width: Get.width * 0.1,
                      child: Image.asset(
                        "assets/images/clear_icon.png",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: query.length < 3
          ? const Center(
              child: Text(
                "Product name must be longer than two letters.",
              ),
            )
          : buildSuggestions(query),
    );
  }

  Widget buildSuggestions(String query) {
    final List<Product> suggestions =
        query.isEmpty ? [] : productsSearchController.productListController.productList.where((product) => product.name.toLowerCase().contains(query.toLowerCase())).toList();
    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final Product suggestion = suggestions[index];
          // return ListTile(
          //   title: Text(suggestion.name),
          //   onTap: () {
          //     this.query = suggestion.name;
          //   },
          // );

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
              title: Text(suggestion.name),
              subtitle: Text(suggestion.description),
              trailing: Text('LKR. ${suggestion.price.toStringAsFixed(2)}'),
              leading: Image.network(suggestion.imgUrl, width: 100, fit: BoxFit.cover),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailScreen(product: suggestion),
                  ),
                );
              },
            ),
          );
        });
  }
}

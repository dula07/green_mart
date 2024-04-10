import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                          onTap: () {},
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.45,
                        child: CategoryCard(
                          categoryName: "Books & Stationary",
                          categoryImage: "assets/images/book.png",
                          onTap: () {},
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
                          onTap: () {},
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.45,
                        child: CategoryCard(
                          categoryName: "Other",
                          categoryImage: "assets/images/more.png",
                          onTap: () {},
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

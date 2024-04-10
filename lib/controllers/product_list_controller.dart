import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/product_model.dart';

class ProductListController extends GetxController {
  RxList<Product> productList = RxList<Product>();

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    var productCollection = FirebaseFirestore.instance.collection('products');
    var querySnapshot = await productCollection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      productList.add(Product.fromFirestore(queryDocumentSnapshot));
    }
  }
}

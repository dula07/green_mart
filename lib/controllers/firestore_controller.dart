import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/product_model.dart';

class FireStoreController extends GetxController {
  Future<List<Product>> fetchProducts() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('products').get();

    return snapshot.docs.map((doc) => Product.fromFirestore(doc)).toList();
  }
}

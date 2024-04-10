import 'package:get/get.dart';

import '../models/product_model.dart';
import 'product_list_controller.dart';

class ProductsSearchBarController extends GetxController {
  ProductListController productListController = Get.put(ProductListController());

  RxList<Product> searchResults = RxList<Product>();

  Future<void> search(String query) async {
    if (productListController.productList.isNotEmpty) {
      searchResults.clear();

      for (Product product in productListController.productList) {
        if (product.name.toLowerCase().contains(query.toLowerCase())) {
          searchResults.add(product);
        }
      }
    }
  }
}

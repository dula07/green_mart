import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import '/controllers/product_search_bar_controller.dart';
import 'controllers/cart_controller.dart';
import 'controllers/firestore_controller.dart';
import 'views/login_screen.dart';
import 'routes/routes.dart';
import 'views/navigation_bar.dart' as nav;

Future main() async {
  // Initialize firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Initialize controllers
  Get.put(FireStoreController());
  Get.put(CartController());
  Get.put(ProductsSearchBarController());

  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: Routes.routes,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFEFF0F5),
        primarySwatch: Colors.blue,
      ),
      home: const PageSwitcher(),
    );
  }
}

class PageSwitcher extends StatelessWidget {
  const PageSwitcher({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Something went wrong!'),
              );
            } else if (snapshot.hasData) {
              // Home screen
              return nav.NavigationBar(
                initialIndex: 0,
              );
            } else {
              return const LoginScreen();
            }
          },
        ),
      );
}

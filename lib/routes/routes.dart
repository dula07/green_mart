import 'package:get/get.dart';

// import '../views/product_search_screen.dart';
import '../views/registration_screen.dart';
import '../views/login_screen.dart';
import '../views/navigation_bar.dart';

class Routes {
  static const String registrationScreen = '/registration-screen';
  static const String loginScreen = '/login-screen';
  static const String homeScreen = '/home-screen';
  static const String productsScreen = '/products-screen';
  static const String cartScreen = '/cart-screen';
  static const String profileScreen = '/profile-screen';
  static const String searchScreen = '/search-screen';

  static String getRegisterScreen() => registrationScreen;
  static String getLogInScreen() => loginScreen;
  static String getHomeScreen() => homeScreen;
  static String getProductsScreen() => productsScreen;
  static String getCartScreen() => cartScreen;
  static String getProfileScreen() => profileScreen;
  static String getSearchScreen() => searchScreen;

  static List<GetPage> routes = [
    GetPage(
      name: registrationScreen,
      page: () => const RegisterScreen(),
    ),
    GetPage(
      name: loginScreen,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: homeScreen,
      page: () => NavigationBar(
        initialIndex: 0,
      ),
    ),
    GetPage(
      name: productsScreen,
      page: () => NavigationBar(
        initialIndex: 1,
      ),
    ),
    GetPage(
      name: cartScreen,
      page: () => NavigationBar(
        initialIndex: 2,
      ),
    ),
    GetPage(
      name: profileScreen,
      page: () => NavigationBar(
        initialIndex: 3,
      ),
    ),
    // GetPage(
    //   name: searchScreen,
    //   page: () => ProductSearchBarScreen(),
    // ),
  ];
}

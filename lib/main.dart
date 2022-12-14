import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ginger_shop/models/cart_model.dart';
import 'package:ginger_shop/models/product_tmp_cart_model.dart';
import 'package:provider/provider.dart';
import 'package:ginger_shop/screens/homepage.dart';
import 'package:ginger_shop/models/user_dao.dart';
import 'package:ginger_shop/screens/login_screen.dart';
import 'package:ginger_shop/screens/add_product.dart';
import 'package:ginger_shop/screens/favourites_page.dart';
import 'package:ginger_shop/screens/product_page.dart';
import 'package:ginger_shop/screens/cart_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserDao>(create: (_) => UserDao()),
        ChangeNotifierProvider<CartModel>(create: (_) => CartModel()),
        ChangeNotifierProvider<ProductTmpCartModel>(
            create: (_) => ProductTmpCartModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/home': (context) => const HomePage(),
          '/favourites': (context) => const FavouritesPage(),
          '/login': (context) => const LoginScreen(),
          '/addProduct': (context) => const AddProduct(),
          '/cart': (context) => const CartScreen(),
        },
        home: const HomePage(),
      ),
    );
  }
}

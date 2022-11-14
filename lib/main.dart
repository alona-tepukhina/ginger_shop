import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:ginger_shop/screens/homepage.dart';
import 'package:ginger_shop/db_operations/user_dao.dart';
import 'package:ginger_shop/screens/login_screen.dart';
import 'package:ginger_shop/screens/add_product.dart';
import 'package:ginger_shop/screens/admin_page.dart';
import 'package:ginger_shop/screens/favourites_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserDao>(
      create: (_) => UserDao(),
      child: MaterialApp(
        routes: {
          '/home': (context) => const HomePage(),
          '/favourites': (context) => const FavouritesPage(),
          '/login': (context) => const LoginScreen(),
          '/admin': (context) => const AdminPage(),
          '/addProduct': (context) => const AddProduct(),
        },
        //home: const HomePage(),
        // home: Consumer<UserDao>(
        //   builder: (_, userDao, child) {
        //     return (userDao.isLoggedIn())
        //         ? const AdminPage()
        //         : const HomePage();
        //   },
        // ),
        home: const HomePage(),
      ),
    );
  }
}

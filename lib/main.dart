import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:ginger_shop/homepage.dart';
import 'package:ginger_shop/registration_screen.dart';
import 'package:ginger_shop/login_screen.dart';
import 'package:ginger_shop/add_product.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/home': (context) => const HomePage(),
        '/login': (context) => const LoginScreen(),
        '/registration': (context) => const RegistrationScreen(),
        '/addProduct': (context) => const AddProduct(),
        //'/admin': (context) => const AdminPage(),
      },
      home: const HomePage(),
    );
  }
}

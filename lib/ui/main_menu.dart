import 'package:flutter/material.dart';
import 'package:ginger_shop/models/user_dao.dart';
import 'package:provider/provider.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    final userDao = context.read<UserDao>();
    bool isAdmin = userDao.isLoggedIn();

    final userMenuItems = [
      ListTile(
        title: const Text('Home'),
        onTap: () => Navigator.of(context).pushNamed('/home'),
      ),
      const Divider(),
      ListTile(
        title: const Text('Favourites'),
        onTap: () => Navigator.of(context).pushNamed('/favourites'),
      ),
      const Divider(),
      ListTile(
        title: const Text('Login'),
        onTap: () => Navigator.of(context).pushNamed('/login'),
      ),
      const Divider(),
    ];

    final adminMenuItems = [
      ListTile(
        title: const Text('Home'),
        onTap: () => Navigator.of(context).pushNamed('/home'),
      ),
      const Divider(),
      ListTile(
        title: const Text('Add product'),
        onTap: () => Navigator.of(context).pushNamed('/addProduct'),
      ),
      const Divider(),
      ListTile(
        title: const Text('Logout'),
        onTap: () {
          userDao.logout();
          Navigator.of(context).pushNamed('/home');
        },
      ),
      const Divider(),
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Column(
        children: isAdmin ? adminMenuItems : userMenuItems,
      ),
    );
  }
}

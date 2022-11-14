import 'package:flutter/material.dart';
import 'package:ginger_shop/db_operations/user_dao.dart';
import 'package:provider/provider.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key, this.isAdmin = false}) : super(key: key);

  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    final userDao = Provider.of<UserDao>(context, listen: false);

    final userMenuItems = [
      ListTile(
        title: const Text('Home'),
        onTap: () => Navigator.of(context).pushNamed('/home'),
      ),
      const Divider(),
      ListTile(
        title: const Text('Login'),
        onTap: () => Navigator.of(context).pushNamed('/login'),
      ),
      const Divider(),
    ];

    final adminMenuItems = [
      // ListTile(
      //   title: const Text('Frontend'),
      //   onTap: () => Navigator.of(context).pushNamed('/home'),
      // ),
      // const Divider(),
      ListTile(
        title: const Text('Admin page'),
        onTap: () => Navigator.of(context).pushNamed('/admin'),
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

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sklens_user_app/pages/cart_page.dart';
import 'package:sklens_user_app/pages/my_profile_page.dart';
import 'package:sklens_user_app/pages/orders_page.dart';

import '../auth/auth_service.dart';
import '../pages/login_page.dart';
import '../utils/helper_functions.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return  Drawer(
      child: ListView(
        children: [
          Container(
            color: Theme.of(context).colorScheme.primary,
            height: 150,
            child: const Center(child: Text('StarGaze E-Shop', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),)),
          ),
          ListTile(
            onTap: () {
              context.pop();
              context.goNamed(MyProfilePage.routeName);
            },
            leading: const Icon(Icons.person),
            title: const Text("My Profile"),
          ),
          ListTile(
            onTap: () {
              context.pop();
              context.goNamed(CartPage.routeName);
            },
            leading: const Icon(Icons.shopping_cart),
            title: const Text("My Cart"),
          ),
          ListTile(
            onTap: () {
              context.pop();
              context.goNamed(OrdersPage.routeName);
            },
            leading: const Icon(Icons.monetization_on),
            title: const Text("My Orders"),
          ),
          ListTile(
            onTap: () {
              AuthService.logout().then((value) {
                showMsg(context, 'Logged out');
                context.goNamed(LoginPage.routeName);
              });
            },
            leading: const Icon(Icons.logout),
            title: const Text("Sign out"),
          )


        ],
      ),
    );
  }
}

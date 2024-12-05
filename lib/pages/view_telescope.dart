import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sklens_user_app/auth/auth_service.dart';
import 'package:sklens_user_app/pages/login_page.dart';
import 'package:sklens_user_app/utils/helper_functions.dart';

class ViewTelescope extends StatefulWidget {
  static const String routeName = '/';
  const ViewTelescope({super.key});

  @override
  State<ViewTelescope> createState() => _ViewTelescopeState();
}

class _ViewTelescopeState extends State<ViewTelescope> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Telescopes'),
      actions: [
        IconButton(onPressed: () {
          _logout();
        }, icon: Icon(Icons.logout))
      ],),

    );
  }

  void _logout() {
    AuthService.logout().then((value) {
      showMsg(context, 'Logged out');
      context.goNamed(LoginPage.routeName);
    });
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sklens_user_app/pages/view_telescope.dart';
import 'package:sklens_user_app/utils/colors.dart';

import '../auth/auth_service.dart';
import '../providers/user_provider.dart';

class LoginSection extends StatefulWidget {
  final VoidCallback onSuccess;
  final Function(String) onFailure;

  const LoginSection(
      {super.key, required this.onSuccess, required this.onFailure});

  @override
  State<LoginSection> createState() => _LoginSectionState();
}

class _LoginSectionState extends State<LoginSection> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    _emailController.text = '';
    _passwordController.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: 'Email Address',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Provide a valid email address';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: 'Password',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password must not be empty';
                }
                return null;
              },
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                backgroundColor: kShrineBrown900,
                foregroundColor: kShrineSurfaceWhite,
              ),
              child: const Text(
                'SIGN IN',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      EasyLoading.show(status: 'Please wait!');
      final email = _emailController.text;
      final password = _passwordController.text;

      try {
        await AuthService.login(email, password);
        EasyLoading.dismiss();
        _reset();
        widget.onSuccess();
        context.goNamed(ViewTelescope.routeName);
      } on FirebaseAuthException catch (error) {
        EasyLoading.dismiss();
        widget.onFailure(error.message!);
      }
    }
  }

  void _reset() {
    _emailController.text = '';
    _passwordController.text = '';
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:sklens_user_app/auth/auth_service.dart';
import 'package:sklens_user_app/providers/user_provider.dart';

import '../utils/colors.dart';

class RegistrationSection extends StatefulWidget {
  final VoidCallback onSuccess;
  final Function(String) onFailure;

  const RegistrationSection(
      {super.key, required this.onSuccess, required this.onFailure});

  @override
  State<RegistrationSection> createState() => _RegistrationSectionState();
}

class _RegistrationSectionState extends State<RegistrationSection> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    _emailController.text = '';
    _passwordController.text = '';
    _nameController.text = '';
    _phoneController.text = '';
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
              controller: _nameController,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Name',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Name must not be empty';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.number,
              maxLength: 9,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.phone),
                  labelText: 'Mobile Number',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Provide a valid mobile number';
                }
                return null;
              },
            ),
          ),
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
              onPressed: _register,
              style: ElevatedButton.styleFrom(
                backgroundColor: kShrineBrown900,
                foregroundColor: kShrineSurfaceWhite,
              ),
              child: const Text('REGISTER',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
    );
  }

  void _register() async {
    if (_formKey.currentState!.validate()) {
      EasyLoading.show(status: 'Please wait!');
      final name = _nameController.text;
      final phone = _phoneController.text;
      final email = _emailController.text;
      final password = _passwordController.text;

      try {
        final user = await AuthService.register(email, password);
        await Provider.of<UserProvider>(context, listen: false).addUser(
            user: user, name: name, phone: phone);
        EasyLoading.dismiss();
        _reset();
        widget.onSuccess();
      } on FirebaseAuthException catch (error) {
        EasyLoading.dismiss();
        widget.onFailure(error.message!);
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _reset() {
    _emailController.text = '';
    _passwordController.text = '';
    _nameController.text = '';
    _phoneController.text = '';
  }
}

import 'package:flutter/material.dart';
import 'package:sklens_user_app/customWidgets/login_section.dart';
import 'package:sklens_user_app/customWidgets/registration_section.dart';
import 'package:sklens_user_app/utils/colors.dart';
import 'package:sklens_user_app/utils/helper_functions.dart';

enum AuthChoice { login, register }

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _errMsg = '';
  AuthChoice _authChoice = AuthChoice.login;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ListView(
        padding: const EdgeInsets.all(24.0),
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              'Welcome, User',
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
          ),
          SegmentedButton<AuthChoice>(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return kShrineBrown900;
                }
                return null;
              }),
              foregroundColor: WidgetStateColor.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return kShrineSurfaceWhite;
                }
                return kShrineBrown900;
              }),
              shape: WidgetStateProperty.resolveWith((states) {
                return RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0));
              }),
            ),
            showSelectedIcon: false,
            segments: const [
              ButtonSegment<AuthChoice>(
                value: AuthChoice.login,
                label: Text('LOGIN',style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              ButtonSegment<AuthChoice>(
                value: AuthChoice.register,
                label: Text('REGISTER',style: TextStyle(fontWeight: FontWeight.bold)),
              )
            ],
            selected: {_authChoice},
            onSelectionChanged: (choice) {
              setState(() {
                _authChoice = choice.first;
              });
            },
          ),
          Card(
            color: kShrineSurfaceWhite,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: AnimatedCrossFade(
                firstChild: LoginSection(
                  onSuccess: () {
                    showMsg(context, 'User Logged in Successfully');
                  },
                  onFailure: (value) {
                    setState(() {
                      _errMsg = value;
                    });
                  },
                ),
                secondChild: RegistrationSection(
                  onSuccess: () {
                    showMsg(context, 'User Registered Successfully, Please Login!');
                  },
                  onFailure: (value) {
                    setState(() {
                      _errMsg = value;
                    });
                  },
                ),
                duration: const Duration(milliseconds: 500),
                crossFadeState: _authChoice == AuthChoice.login
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
              ),
            ),
          ),
          if(_errMsg.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(_errMsg, style: TextStyle(fontSize: 18, color: Colors.red),),
            ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('OR', textAlign: TextAlign.center, style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: kShrineBrown900,
              foregroundColor: kShrineSurfaceWhite
            ),
            onPressed: _signInWithGoogle,
            icon: const Icon(Icons.g_mobiledata),
            label: const Text('SIGN IN WITH GOOGLE', style: TextStyle(fontWeight: FontWeight.bold),)
          )

        ],
      ),
    ));
  }

  void _signInWithGoogle() {
  }
}

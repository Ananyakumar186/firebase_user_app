import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sklens_user_app/auth/auth_service.dart';
import 'package:sklens_user_app/providers/user_provider.dart';

import '../models/app_user.dart';

class MyProfilePage extends StatefulWidget {
  static const String routeName = 'profile_page';

  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Consumer<UserProvider>(
        builder: (context, provider, child) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                buildColumn('Name', provider.appUser!.userName!),
                buildColumn('Email', provider.appUser!.email),
                buildColumn('Mobile Number', provider.appUser!.phone!),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text('Address', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('${provider.appUser!.userAddress!.streetAdress},'),
                    Text('${provider.appUser!.userAddress!.city},'),
                    Text('${provider.appUser!.userAddress!.country} , ${provider.appUser!.userAddress!.postCode}')
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildColumn(headerName, value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [Text(headerName, style: const TextStyle(fontWeight: FontWeight.bold),), Text(value)],
      ),
    );
  }
}

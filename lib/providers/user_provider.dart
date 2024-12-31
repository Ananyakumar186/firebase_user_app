import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sklens_user_app/auth/auth_service.dart';
import 'package:sklens_user_app/models/app_user.dart';

import '../db/dbHelper.dart';

class UserProvider extends ChangeNotifier {
  AppUser? appUser;
  Future<void> addUser({required User user, String? name, String? phone}) {
    final appUser = AppUser(uid: user.uid,
      email: user.email!,
      userName: name,
      phone: phone,
      userCreationTime: Timestamp.fromDate(user.metadata.creationTime!), userAddress: null);
    return DbHelper.addUser(appUser);
  }

   getUserInfo() {
    DbHelper.getUserInfo(AuthService.currentUser!.uid).listen((event) {
      if(event.exists){
        appUser = AppUser.fromJson(event.data()!);
        if (kDebugMode) {
          print('user info');
          print(appUser);
        }

        notifyListeners();
      }
    });
  }

  Future<bool> doesUserExist(String uid) => DbHelper.doesUserExist(uid);

}
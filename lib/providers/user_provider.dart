import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sklens_user_app/models/app_user.dart';

import '../db/dbHelper.dart';

class UserProvider extends ChangeNotifier {

  Future<void> addUser({required User user, String? name, String? phone}) {
    final appUser = AppUser(uid: user.uid,
      email: user.email!,
      userName: name,
      phone: phone,
      userCreationTime: Timestamp.fromDate(user.metadata.creationTime!));
    return DbHelper.addUser(appUser);
  }

}
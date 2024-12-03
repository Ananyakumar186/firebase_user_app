import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sklens_user_app/models/app_user.dart';

class DbHelper {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static const String collectionUser = 'Users';
  static const String collectionTelescope = 'Telescope';
  static const String collectionBrand = 'Brands';

  static Future<void> addUser(AppUser appUser) {
    return _db.collection(collectionUser).doc(appUser.uid).set(appUser.toJson());
  }

}
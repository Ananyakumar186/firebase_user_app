import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sklens_user_app/models/app_user.dart';

class DbHelper {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static const String collectionUser = 'Users';
  static const String collectionTelescope = 'Telescopes';
  static const String collectionBrand = 'Brands';

  static Future<void> addUser(AppUser appUser) {
    return _db.collection(collectionUser).doc(appUser.uid).set(appUser.toJson());
  }

  static Future<bool> doesUserExist(String uid) async{
    final snapshot = await _db.collection(collectionUser).doc(uid).get();
    return snapshot.exists;
  }
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllBrands() => _db.collection(collectionBrand).snapshots();

  static Stream<QuerySnapshot<Map<dynamic,dynamic>>> getAllTelescopes() => _db.collection(collectionTelescope).snapshots();
}
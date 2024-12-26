import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sklens_user_app/models/app_user.dart';
import 'package:sklens_user_app/models/cart.dart';

class DbHelper {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static const String collectionUser = 'Users';
  static const String collectionTelescope = 'Telescopes';
  static const String collectionBrand = 'Brands';
  static const String collectionCart = 'MyCartItems';

  static Future<void> addUser(AppUser appUser) {
    return _db
        .collection(collectionUser)
        .doc(appUser.uid)
        .set(appUser.toJson());
  }

  static Future<void> addToCart(CartModel cartModel, String uid) {
    return _db
        .collection(collectionUser)
        .doc(uid)
        .collection(collectionCart)
        .doc(cartModel.telescopeId)
        .set(cartModel.toJson());
  }

  static Future<void> removeFromCart(String telId, String uid) {
    return _db
        .collection(collectionUser)
        .doc(uid)
        .collection(collectionCart)
        .doc(telId)
        .delete();
  }

  static Future<bool> doesUserExist(String uid) async {
    final snapshot = await _db.collection(collectionUser).doc(uid).get();
    return snapshot.exists;
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllBrands() =>
      _db.collection(collectionBrand).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllTelescopes() =>
      _db.collection(collectionTelescope).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllCartItems(
          String uid) =>
      _db
          .collection(collectionUser)
          .doc(uid)
          .collection(collectionCart)
          .snapshots();

  static Future<void> updateCartQuantity(String uid, CartModel model) {
    return _db
        .collection(collectionUser)
        .doc(uid)
        .collection((collectionCart))
        .doc(model.telescopeId)
        .set(model.toJson());
  }
}

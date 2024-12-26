import 'package:flutter/material.dart';
import 'package:sklens_user_app/auth/auth_service.dart';
import 'package:sklens_user_app/db/dbHelper.dart';
import 'package:sklens_user_app/models/cart.dart';
import 'package:sklens_user_app/models/telescope.dart';
import 'package:sklens_user_app/utils/helper_functions.dart';

class CartProvider extends ChangeNotifier {
  List<CartModel> cartList = [];

  getAllCartItems(){
    DbHelper.getAllCartItems(AuthService.currentUser!.uid).listen((snapshot){
      cartList = List.generate(snapshot.docs.length, (index) => CartModel.fromJson(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

  bool isTelescopeInCart(String id) {
    bool tag = false;
    for (final cartModel in cartList) {
      if (cartModel.telescopeId == id) {
        tag = true;
        break;
      }
    }
    return tag;
  }

  Future<void> addToCart(Telescope telescope) {
    final cartModel = CartModel(
        telescopeId: telescope.id!,
        telescopeModel: telescope.model,
        price: priceAfterDiscount(telescope.price, telescope.discount),
        imageUrl: telescope.thumbnail.downloadUrl, quantity: 0);
    return DbHelper.addToCart(cartModel, AuthService.currentUser!.uid);
  }
  
  Future<void> remoceFromCart(String id){
    return DbHelper.removeFromCart(id, AuthService.currentUser!.uid);
  }

  void increaseQuantity(CartModel model) {
    model.quantity += 1;
    DbHelper.updateCartQuantity(AuthService.currentUser!.uid, model);
  }
  void decreaseQuantity(CartModel model) {
    if(model.quantity > 1) {
      model.quantity -= 1;
      DbHelper.updateCartQuantity(AuthService.currentUser!.uid, model);
    }
  }

  num priceWithQuantity(CartModel model) => model.price * model.quantity;

  num getCartSubTotal() {
    num total = 0;
    for (final model in cartList) {
      total += priceWithQuantity(model);
    }
    return total;
  }
}

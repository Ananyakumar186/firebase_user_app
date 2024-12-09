import 'package:flutter/material.dart';
import 'package:sklens_user_app/models/cart.dart';

class CartProvider extends ChangeNotifier {
   List<CartModel> cartList = [];

    bool isTelescopeInCart(String id) {
      bool tag = false;
      for(final cartModel in cartList){
        if(cartModel.telescopeId == id){
          tag = true;
              break;
        }
      }
      return tag;
    }


}
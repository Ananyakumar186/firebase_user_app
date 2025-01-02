import 'package:flutter/material.dart';
import 'package:sklens_user_app/db/dbHelper.dart';
import 'package:sklens_user_app/models/order_model.dart';

import '../auth/auth_service.dart';
import '../models/cart.dart';

class OrderProvider extends ChangeNotifier {
  List<OrderModel> orderList = [];
  List<CartModel> itemDetails = [];
  late OrderModel orderModel;
  Future<void> saveOrder(OrderModel order) {
    return DbHelper.saveOrder(order);
  }

  Future<void> getAllOrders() async {
    DbHelper.getAllOrders(AuthService.currentUser!.uid).listen((event) {
      orderList = List.generate(event.docs.length, (index) => OrderModel.fromJSON(event.docs[index].data()));
      orderList.map((e) => e.appUser.uid == AuthService.currentUser!.uid!);
      for(final order in orderList) {
        for(final item in order.itemDetails) {
          itemDetails.add(item);
        }
      }
    });
    notifyListeners();
      // orderList = List.generate(snapshot.docs.length, (index) => OrderModel.fromJSON(snapshot.docs[index].data()));

  }
  num priceWithQuantity(CartModel model) => model.price * model.quantity;
}
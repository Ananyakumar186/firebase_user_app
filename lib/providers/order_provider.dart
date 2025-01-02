import 'package:flutter/material.dart';
import 'package:sklens_user_app/db/dbHelper.dart';
import 'package:sklens_user_app/models/order_model.dart';

import '../auth/auth_service.dart';

class OrderProvider extends ChangeNotifier {
  List<OrderModel> orderList = [];
  late OrderModel orderModel;
  Future<void> saveOrder(OrderModel order) {
    return DbHelper.saveOrder(order);
  }

  Future<void> getAllOrders() async {
    final list = await DbHelper.getAllOrders(AuthService.currentUser!.uid).listen((event) {
      orderList = List.generate(event.docs.length, (index) => OrderModel.fromJSON(event.docs[index].data()));
      orderList.map((e) => e.appUser.uid == AuthService.currentUser!.uid!);
      print(orderList.toString());
    });
    notifyListeners();
      // orderList = List.generate(snapshot.docs.length, (index) => OrderModel.fromJSON(snapshot.docs[index].data()));

  }

}
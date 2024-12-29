import 'package:flutter/material.dart';
import 'package:sklens_user_app/db/dbHelper.dart';
import 'package:sklens_user_app/models/order_model.dart';

class OrderProvider extends ChangeNotifier {
  List<OrderModel> orderList = [];

  Future<void> saveOrder(OrderModel order) {
    return DbHelper.saveOrder(order);
  }


}
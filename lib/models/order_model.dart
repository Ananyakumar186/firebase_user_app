import 'package:cloud_firestore/cloud_firestore.dart';

import 'app_user.dart';
import 'cart.dart';

class OrderModel {
  String orderId;
  AppUser appUser;
  String orderStatus;
  String paymentMethod;
  num totalAmount;
  Timestamp orderDate;
  List<CartModel> itemDetails;

  OrderModel({
      required this.orderId,
      required this.appUser,
      required this.orderStatus,
      required this.paymentMethod,
      required this.totalAmount,
      required this.orderDate,
      required this.itemDetails
  });


  Map<String, dynamic> toJSON() {
    return {
      'orderId': orderId,
      'appUser': appUser.toJson(),
      'orderStatus': orderStatus,
      'paymentMethod': paymentMethod,
      'totalAmount': totalAmount,
      'orderDate': orderDate,
      'itemDetails': itemDetails.map((item) => item.toJson()).toList(),
    };
  }


  factory OrderModel.fromJSON(Map<String, dynamic> map) {
    return OrderModel(
      orderId: map['orderId'] ?? '',
      appUser: AppUser.fromJson(map['appUser']),
      orderStatus: map['orderStatus'] ?? '',
      paymentMethod: map['paymentMethod'] ?? '',
      totalAmount: map['totalAmount'] ?? 0,
      orderDate: map['orderDate'] ?? Timestamp.now(),
      itemDetails: List<CartModel>.from(map['itemDetails'].map((item) => CartModel.fromJson(item)).toList()),
    );
  }

}

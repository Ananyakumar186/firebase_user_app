import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sklens_user_app/models/cart.dart';
import 'package:sklens_user_app/utils/constants.dart';

import '../models/order_model.dart';
import '../providers/cart_provider.dart';
import '../providers/order_provider.dart';



class OrderItemView extends StatefulWidget {
  final OrderModel orderModel;
  final OrderProvider provider;

  const OrderItemView(
      {super.key, required this.orderModel, required this.provider});

  @override
  State<OrderItemView> createState() => _OrderItemViewState();



}

class _OrderItemViewState extends State<OrderItemView> {

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sklens_user_app/providers/cart_provider.dart';
import 'package:sklens_user_app/providers/order_provider.dart';

import '../customWidgets/order_item_view.dart';


class OrdersPage extends StatefulWidget {
  static const String routeName = 'orderPage';

  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      body: Consumer<OrderProvider>(
        builder: (context, provider, child) =>
            Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: provider.orderList.length,
                    itemBuilder: (context, index) {
                      final orderList = provider.orderList[index];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(orderList.orderDate.toDate().toString()),
                                trailing: Text(orderList.orderStatus)
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: orderList.itemDetails.length,
                                itemBuilder: (context, index) {
                                  final itemDetail = orderList.itemDetails[index];
                                  return OrderItemView(
                                      itemDetail: itemDetail, provider: provider);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

              ],
            ),
      ),
    );
  }
}

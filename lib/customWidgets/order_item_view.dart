import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sklens_user_app/models/cart.dart';
import 'package:sklens_user_app/providers/cart_provider.dart';
import 'package:sklens_user_app/providers/order_provider.dart';

import '../utils/constants.dart';

class OrderItemView extends StatelessWidget {
  final CartModel itemDetail;
  final OrderProvider provider;

  const OrderItemView({super.key, required this.itemDetail, required this.provider });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(

        children: [
          ListTile(
            leading: CachedNetworkImage(
              width: 70,
              height: 70,
              imageUrl: itemDetail.imageUrl,
              placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            title: Text(itemDetail.telescopeModel),
            subtitle: Text('Quantity ${itemDetail.quantity}'),
            trailing: Text(
                '$currencySymbol${provider.priceWithQuantity(itemDetail)}'),
          ),
        ],
      ),
    );
  }
}

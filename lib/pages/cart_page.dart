import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sklens_user_app/customWidgets/login_section.dart';
import 'package:sklens_user_app/pages/checkout_page.dart';
import 'package:sklens_user_app/providers/cart_provider.dart';
import 'package:sklens_user_app/utils/constants.dart';

import 'cart_item_view.dart';

class CartPage extends StatefulWidget {
  static const String routeName = 'cartpage';

  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
      ),
      body: Consumer<CartProvider>(
        builder: (context, provider, child) => Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: provider.cartList.length,
                  itemBuilder: (context, index) {
                    final model = provider.cartList[index];
                    return CartItemView(cartModel: model, provider: provider);
                  }),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'SUB TOTAL: $currencySymbol${provider.getCartSubTotal()}',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    OutlinedButton(
                        onPressed: () {
                          context.goNamed(CheckoutPage.routeName);
                        },
                        child: const Text('CHECKOUT'))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

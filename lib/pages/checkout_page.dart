import 'package:cached_network_image/cached_network_image.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sklens_user_app/models/cart.dart';
import 'package:sklens_user_app/providers/cart_provider.dart';
import 'package:sklens_user_app/utils/colors.dart';

import '../utils/constants.dart';

enum PaymentType {
  cod('Cash on Delivery'),
  online('Online Payment');

  final String text;

  const PaymentType(this.text);
}

class CheckoutPage extends StatefulWidget {
  static const String routeName = 'checkoutpage';

  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  var _streetAddress = TextEditingController();
  var _pinCode = TextEditingController();
  var _city = TextEditingController();
  var _state = TextEditingController();
  var _country = TextEditingController();
  PaymentType _methodOption = PaymentType.cod;

  @override
  void initState() {
    // TODO: implement initState
    _streetAddress.text = '';
    _pinCode.text = '';
    _city.text = '';
    _state.text = '';
    _country.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Confirm Order'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text('Product Information'),
              Consumer<CartProvider>(
                builder: (context, provider, child) => ListView.builder(
                  shrinkWrap: true,
                  itemCount: provider.cartList.length,
                  itemBuilder: (context, index) => Card(
                    child: ListTile(
                      leading: CachedNetworkImage(
                        width: 40,
                        height: 40,
                        imageUrl: provider.cartList[index].imageUrl,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                      title: Text(provider.cartList[index].telescopeModel),
                      subtitle:
                          Text('Quantity ${provider.cartList[index].quantity}'),
                      trailing: Text(
                          '$currencySymbol${provider.priceWithQuantity(provider.cartList[index])}'),
                    ),
                  ),
                ),
              ),
              Consumer<CartProvider>(
                builder: (context, provider, child) => Card(
                  child: ListTile(
                    title: Text('Total Amount'),
                    trailing:
                        Text('$currencySymbol${provider.getCartSubTotal()}'),
                  ),
                ),
              ),

              const Text('Delivery Address'),
              Card(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _streetAddress,
                        decoration: const InputDecoration(
                          hintText: 'street address',
                          focusColor: kShrineBrown900,
                        ),
                        onChanged: (value) {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _pinCode,
                        decoration: const InputDecoration(
                          hintText: 'pin code',
                          focusColor: kShrineBrown900,
                        ),
                        onChanged: (value) {},
                      ),
                    ),
                    CSCPicker(
                      showCities: true,
                      showStates: true,
                      onCountryChanged: (value) {
                        setState(() {
                          _country.text = value;
                        });
                      },
                      onStateChanged: (value) {
                        setState(() {
                          _state.text = value ?? '';
                        });
                      },
                      onCityChanged: (value) {
                        setState(() {
                          _city.text = value ?? '';
                        });
                      },
                    )
                  ],
                ),
              ),

              const Text('Payment Method'),
              Card(
                child: Row(
                  children: PaymentType.values.map((option) => RadioMenuButton(
                      value: option,
                      groupValue: _methodOption,
                      onChanged: (value) {
                        setState(() {
                          _methodOption = value!;
                        });
                      },
                      child: Text(option.text))).toList(),
                ),
              )
            ],
          ),
        ));
  }
}

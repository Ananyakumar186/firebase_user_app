import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sklens_user_app/customWidgets/login_section.dart';
import 'package:sklens_user_app/models/cart.dart';
import 'package:sklens_user_app/models/order_model.dart';
import 'package:sklens_user_app/models/user_address.dart';
import 'package:sklens_user_app/pages/view_telescope.dart';
import 'package:sklens_user_app/providers/cart_provider.dart';
import 'package:sklens_user_app/providers/user_provider.dart';
import 'package:sklens_user_app/utils/colors.dart';
import 'package:sklens_user_app/utils/helper_functions.dart';

import '../providers/order_provider.dart';
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
  String optionSelected = PaymentType.cod.toString();

  @override
  void initState() {

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
                builder: (context, provider, child) =>
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: provider.cartList.length,
                      itemBuilder: (context, index) =>
                          Card(
                            child: ListTile(
                              leading: CachedNetworkImage(
                                width: 40,
                                height: 40,
                                imageUrl: provider.cartList[index].imageUrl,
                                placeholder: (context, url) =>
                                const Center(
                                    child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                              ),
                              title: Text(
                                  provider.cartList[index].telescopeModel),
                              subtitle:
                              Text('Quantity ${provider.cartList[index]
                                  .quantity}'),
                              trailing: Text(
                                  '$currencySymbol${provider.priceWithQuantity(
                                      provider.cartList[index])}'),
                            ),
                          ),
                    ),
              ),
              Consumer<CartProvider>(
                builder: (context, provider, child) =>
                    Card(
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
                  children: PaymentType.values
                      .map((option) =>
                      RadioMenuButton(
                          value: option,
                          groupValue: _methodOption,
                          onChanged: (value) {
                            setState(() {
                              _methodOption = value!;
                              optionSelected = value.text.toString();
                            });
                          },
                          child: Text(option.text)))
                      .toList(),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _placeOrder();
                },
                child: Text('Place Order'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: kShrineBrown900,
                    foregroundColor: kShrineSurfaceWhite),
              )
            ],
          ),
        ));
  }

  Future<void> _placeOrder() async {
    if (_streetAddress.text.isEmpty || _pinCode.text.isEmpty ||
        _country.text.isEmpty || _city.text.isEmpty || _state.text.isEmpty) {
      showMsg(context, 'Please enter complete Delivery Address');
    }
    else {
      EasyLoading.show(status: 'Placing order');
      final userAddress = UserAddress(streetAdress: _streetAddress.text,
          city: _city.text,
          postCode: _pinCode.text,
          country: _country.text,
          state: _state.text
      );

      final appUser = Provider
          .of<UserProvider>(context, listen: false)
          .appUser;
      appUser!.userAddress = userAddress;

      final totalAmount = Provider.of<CartProvider>(context, listen: false).getCartSubTotal();
      final cartList = Provider.of<CartProvider>(context, listen: false).cartList;

      final order = OrderModel(orderId: generateOrderId,
          appUser: appUser,
          orderStatus: OrderStatus.pending,
          paymentMethod: _methodOption.text,
          totalAmount: totalAmount,
          orderDate: Timestamp.fromDate(DateTime.now()),
          itemDetails: cartList
      );

      try {
        await Provider.of<OrderProvider>(context,listen: false).saveOrder(order);
        await Provider.of<CartProvider>(context, listen: false).clearCart();
        EasyLoading.dismiss();
        showMsg(context, 'Order Placed');
        context.goNamed(ViewTelescope.routeName);
      } catch(error){
        EasyLoading.dismiss();
        showMsg(context, error.toString());
      }
    }
  }
}

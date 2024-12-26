import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sklens_user_app/auth/auth_service.dart';
import 'package:sklens_user_app/customWidgets/main_drawer.dart';
import 'package:sklens_user_app/pages/login_page.dart';
import 'package:sklens_user_app/providers/cart_provider.dart';
import 'package:sklens_user_app/providers/telescope_provider.dart';
import 'package:sklens_user_app/utils/helper_functions.dart';

import '../customWidgets/telescope_grid_item_view.dart';

class ViewTelescope extends StatefulWidget {
  static const String routeName = '/';

  const ViewTelescope({super.key});

  @override
  State<ViewTelescope> createState() => _ViewTelescopeState();
}

class _ViewTelescopeState extends State<ViewTelescope> {
  @override
  void didChangeDependencies() {
    Provider.of<TelescopeProvider>(context, listen: false).getAllTelescopes();
    Provider.of<CartProvider>(context, listen: false).getAllCartItems();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MainDrawer(),
      appBar: AppBar(
        title: const Text('Telescopes'),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         _logout();
        //       },
        //       icon: Icon(Icons.logout))
        // ],
      ),
      body: Consumer<TelescopeProvider>(
        builder: (context, provider, child) => GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 0.7),
          itemCount: provider.telescopeList.length,
          itemBuilder: (context, index) {
            final telescope = provider.telescopeList[index];
            print(telescope.thumbnail.downloadUrl);
            return TelescopeGridItemView(telescope: telescope);
          },
        ),
      ),
    );
  }
}

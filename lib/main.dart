import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sklens_user_app/auth/auth_service.dart';
import 'package:sklens_user_app/pages/login_page.dart';
import 'package:sklens_user_app/pages/telescope_detail_page.dart';
import 'package:sklens_user_app/pages/view_telescope.dart';
import 'package:sklens_user_app/providers/cart_provider.dart';
import 'package:sklens_user_app/providers/telescope_provider.dart';
import 'package:sklens_user_app/providers/user_provider.dart';
import 'package:sklens_user_app/utils/colors.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => UserProvider()),
    ChangeNotifierProvider(create: (context) => TelescopeProvider()),
    ChangeNotifierProvider(create: (context) => CartProvider()),
  ], child:  MyApp()));
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  ThemeData _buildShrineTheme() {
    final ThemeData base = ThemeData.light(useMaterial3: true);
    return base.copyWith(
        colorScheme: base.colorScheme.copyWith(
            primary: kShrinePink400,
            onPrimary: kShrineBrown900,
            secondary: kShrineBrown900,
            error: kShrineErrorRed),
        textTheme: _buildShrineTextTheme(GoogleFonts.ralewayTextTheme()),
        textSelectionTheme:
            const TextSelectionThemeData(selectionColor: kShrinePink100));
  }

  TextTheme _buildShrineTextTheme(TextTheme base) {
    return base
        .copyWith(
          headlineSmall: base.headlineSmall!.copyWith(
            fontWeight: FontWeight.w500,
          ),
          titleLarge: base.titleLarge!.copyWith(
            fontSize: 18.0,
          ),
          bodySmall: base.bodySmall!
              .copyWith(fontWeight: FontWeight.w400, fontSize: 14.0),
          bodyLarge: base.bodySmall!
              .copyWith(fontWeight: FontWeight.w500, fontSize: 16.0),
        )
        .apply(
          displayColor: kShrineBrown900,
          bodyColor: kShrineBrown900,
        );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: _buildShrineTheme(),
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      routerConfig: _router,
    );
  }

  final _router = GoRouter(
      initialLocation: ViewTelescope.routeName,
      debugLogDiagnostics: true,
      redirect: (context, state) {
        if (AuthService.currentUser == null) {
          return LoginPage.routeName;
        }
        return null;
      },
      routes: [
        GoRoute(
          path: LoginPage.routeName,
          name: LoginPage.routeName,
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: ViewTelescope.routeName,
          name: ViewTelescope.routeName,
          builder: (context, state) => const ViewTelescope(),
          routes: [
            GoRoute(
              path: TelescopeDetailPage.routeName,
              name: TelescopeDetailPage.routeName,
              builder: (context, state) =>  TelescopeDetailPage(id: state.extra! as String,),
            )
          ]
        )
      ]);
}

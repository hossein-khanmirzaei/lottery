import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lottery/providers/overview_provider.dart';
import 'package:lottery/screens/overview_screen.dart';
import 'package:provider/provider.dart';
import 'package:lottery/providers/auth_provider.dart';

// import './screens/cart_screen.dart';
// import './screens/products_overview_screen.dart';
// import './screens/product_detail_screen.dart';
// import './providers/products.dart';
// import './providers/cart.dart';
// import './providers/orders.dart';
// import './screens/orders_screen.dart';
// import './screens/user_products_screen.dart';
// import './screens/edit_product_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AuthProvider(),
        ),
        ChangeNotifierProvider.value(
          value: OverviewProvider(),
        ),
        // ChangeNotifierProvider.value(
        //   value: Cart(),
        // ),
        // ChangeNotifierProvider.value(
        //   value: Orders(),
        // ),
      ],
      child: Consumer<AuthProvider>(
        builder: (ctx, auth, _) => MaterialApp(
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
              Locale("fa", "IR"),
            ],
            locale: Locale("fa", "IR"),
            title: 'MyShop',
            theme: ThemeData(
              primarySwatch: Colors.purple,
              accentColor: Colors.deepOrange,
              fontFamily: 'IRANSans',
            ),
            //home: auth.isAuth ? OverviewScreen() : AuthScreen(),
            home: OverviewScreen(),
            routes: {
              // ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
              // CartScreen.routeName: (ctx) => CartScreen(),
              // OrdersScreen.routeName: (ctx) => OrdersScreen(),
              // UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
              // EditProductScreen.routeName: (ctx) => EditProductScreen(),
            }),
      ),
    );
  }
}

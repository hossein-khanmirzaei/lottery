import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lottery/providers/creditcards.dart';
import 'package:lottery/providers/overview.dart';
import 'package:lottery/providers/transactions.dart';
import 'package:lottery/screens/auth_screen.dart';
import 'package:lottery/screens/credit_card_screen.dart';
import 'package:lottery/screens/login.dart';
import 'package:lottery/screens/overview_screen.dart';
import 'package:lottery/screens/signup.dart';
import 'package:provider/provider.dart';
import 'package:lottery/providers/auth.dart';

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
        ChangeNotifierProvider.value(
          value: TransactionProvider(),
        ),
        ChangeNotifierProvider.value(
          value: CreditCardProvider(),
        ),
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
              accentColor: Colors.white,
              canvasColor: Colors.white54,
              fontFamily: 'IRANSans',
            ),
            home: auth.isAuth ? OverviewScreen() : AuthScreen(),
            //home: AuthScreen(),
            routes: {
              // ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
              SignupScreen.routeName: (ctx) => SignupScreen(),
              LoginScreen.routeName: (ctx) => LoginScreen(),
              CreditCardScreen.routeName: (ctx) => CreditCardScreen(),
              // OrdersScreen.routeName: (ctx) => OrdersScreen(),
              // UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
              // EditProductScreen.routeName: (ctx) => EditProductScreen(),
            }),
      ),
    );
  }
}

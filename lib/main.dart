import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lottery/providers/creditcard.dart';
import 'package:lottery/providers/news.dart';
import 'package:lottery/providers/overview.dart';
import 'package:lottery/providers/store.dart';
import 'package:lottery/providers/transaction.dart';
import 'package:lottery/screens/creditcard.dart';
import 'package:lottery/screens/login.dart';
import 'package:lottery/screens/new_creditcard.dart';
import 'package:lottery/screens/news_detail.dart';
import 'package:lottery/screens/overview.dart';
import 'package:lottery/screens/signup.dart';
import 'package:lottery/screens/verification.dart';
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
          value: NewsProvider(),
        ),
        ChangeNotifierProvider.value(
          value: TransactionProvider(),
        ),
        ChangeNotifierProvider.value(
          value: CreditCardProvider(),
        ),
        ChangeNotifierProvider.value(
          value: StoreProvider(),
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
            canvasColor: Colors.lightBlue[50],
            fontFamily: 'IRANSans',
          ),
          //home: auth.isAuth ? OverviewScreen() : StartScreen(),
          home: OverviewScreen(),
          routes: {
            // ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            SignupScreen.routeName: (ctx) => SignupScreen(),
            VerificationScreen.routeName: (ctx) => VerificationScreen(),
            LoginScreen.routeName: (ctx) => LoginScreen(),
            OverviewScreen.routeName: (ctx) => OverviewScreen(),
            CreditCardScreen.routeName: (ctx) => CreditCardScreen(),
            NewCreditCardScreen.routeName: (ctx) => NewCreditCardScreen(),
            NewsDetailScreen.routeName: (ctx) => NewsDetailScreen(),
            // OrdersScreen.routeName: (ctx) => OrdersScreen(),
            // UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            // EditProductScreen.routeName: (ctx) => EditProductScreen(),
          },
        ),
      ),
    );
  }
}

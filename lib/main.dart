import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lottery/providers/creditcard.dart';
import 'package:lottery/providers/help.dart';
import 'package:lottery/providers/lottery.dart';
import 'package:lottery/providers/news.dart';
import 'package:lottery/providers/store.dart';
import 'package:lottery/providers/transaction.dart';
import 'package:lottery/providers/user.dart';
import 'package:lottery/screens/about.dart';
import 'package:lottery/screens/creditcard.dart';
import 'package:lottery/screens/edit_creditcard.dart';
import 'package:lottery/screens/help_detail.dart';
import 'package:lottery/screens/help_list.dart';
import 'package:lottery/screens/login.dart';
import 'package:lottery/screens/lottery_detail.dart';
import 'package:lottery/screens/new_creditcard.dart';
import 'package:lottery/screens/news_detail.dart';
import 'package:lottery/screens/overview.dart';
import 'package:lottery/screens/rules.dart';
import 'package:lottery/screens/signup.dart';
import 'package:lottery/screens/splash.dart';
import 'package:lottery/screens/store_detail.dart';
import 'package:lottery/screens/transaction_detail.dart';
import 'package:lottery/screens/user_password.dart';
import 'package:lottery/screens/user_setting.dart';
import 'package:lottery/screens/verification.dart';
import 'package:provider/provider.dart';
import 'package:lottery/providers/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AuthProvider(),
        ),
        // ChangeNotifierProxyProvider<AuthProvider, OverviewProvider>(
        //   builder: (_, auth, __) => OverviewProvider(auth.currentUser),
        // ),
        ChangeNotifierProxyProvider<AuthProvider, TransactionProvider>(
          //create: (ctx) => TransactionProvider(),
          update: (_, auth, __) => TransactionProvider(auth.currentUser),
        ),
        ChangeNotifierProxyProvider<AuthProvider, NewsProvider>(
          update: (_, auth, __) => NewsProvider(auth.currentUser),
        ),
        ChangeNotifierProxyProvider<AuthProvider, CreditCardProvider>(
          update: (_, auth, __) => CreditCardProvider(auth.currentUser),
        ),
        ChangeNotifierProxyProvider<AuthProvider, StoreProvider>(
          update: (_, auth, __) => StoreProvider(auth.currentUser),
        ),
        ChangeNotifierProxyProvider<AuthProvider, UserProvider>(
          update: (_, auth, __) => UserProvider(auth.currentUser),
        ),
        ChangeNotifierProxyProvider<AuthProvider, HelpProvider>(
          update: (_, auth, __) => HelpProvider(auth.currentUser),
        ),
        ChangeNotifierProxyProvider<AuthProvider, LotteryProvider>(
          update: (_, auth, __) => LotteryProvider(auth.currentUser),
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
            // appBarTheme: AppBarTheme(
            //   color: Colors.transparent,
            // ),
            fontFamily: 'IRANSans',
          ),
          home: auth.isAuth
              ? OverviewScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : LoginScreen(),
                ),
          //home: OverviewScreen(),
          routes: {
            SignupScreen.routeName: (ctx) => SignupScreen(),
            VerificationScreen.routeName: (ctx) => VerificationScreen(),
            LoginScreen.routeName: (ctx) => LoginScreen(),
            OverviewScreen.routeName: (ctx) => OverviewScreen(),
            CreditCardScreen.routeName: (ctx) => CreditCardScreen(),
            EditCreditCardScreen.routeName: (ctx) => EditCreditCardScreen(),
            TransactionDetailScreen.routeName: (ctx) =>
                TransactionDetailScreen(),
            StoreDetailScreen.routeName: (ctx) => StoreDetailScreen(),
            LotteryDetailScreen.routeName: (ctx) => LotteryDetailScreen(),
            NewCreditCardScreen.routeName: (ctx) => NewCreditCardScreen(),
            NewsDetailScreen.routeName: (ctx) => NewsDetailScreen(),
            UserSettingsScreen.routeName: (ctx) => UserSettingsScreen(),
            UserPasswordScreen.routeName: (ctx) => UserPasswordScreen(),
            AboutScreen.routeName: (ctx) => AboutScreen(),
            RulesScreen.routeName: (ctx) => RulesScreen(),
            HelpListScreen.routeName: (ctx) => HelpListScreen(),
            HelpDetailScreen.routeName: (ctx) => HelpDetailScreen(),
          },
        ),
      ),
    );
  }
}

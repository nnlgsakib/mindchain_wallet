import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/provider/account_details_provider.dart';
import 'package:mindchain_wallet/presentation/provider/create_new_wallet_provider.dart';
import 'package:mindchain_wallet/presentation/provider/send_token_provider.dart';
import 'package:mindchain_wallet/presentation/provider/splash_Screen_provider.dart';
import 'package:mindchain_wallet/presentation/screens/auth/splash_screen.dart';
import 'package:mindchain_wallet/presentation/screens/auth/welcome_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => CreateWalletProvider(),),
    ChangeNotifierProvider(create: (context) => SendTokenProvider(),),
    ChangeNotifierProvider(create: (context) => SplashScreenProvider(),),
    ChangeNotifierProvider(create: (context) => AccountDetailsProvider(),),
  ],child: const MindWallet(),),);
}

class MindWallet extends StatelessWidget {
  const MindWallet({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}

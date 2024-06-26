import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/provider/account_details_provider.dart';
import 'package:mindchain_wallet/presentation/provider/create_new_wallet_provider.dart';
import 'package:mindchain_wallet/presentation/widget/backgroundwidget.dart';
import 'package:mindchain_wallet/presentation/widget/dashboard/assets_and_trx_tapbar.dart';
import 'package:mindchain_wallet/presentation/widget/dashboard/dashboard_card.dart';
import 'package:mindchain_wallet/presentation/widget/dashboard/send_receive_assets_row.dart';
import 'package:mindchain_wallet/presentation/widget/dashboard/wallet_balance_card.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    loadBal();
  }

  loadBal() async {
    Future.delayed(
      const Duration(milliseconds: 100),
      () => Provider.of<CreateWalletProvider>(context, listen: false)
          .loadBalance(),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: BackgroundWidget(
        child: RefreshIndicator(
          onRefresh: () async {
            await Provider.of<AccountDetailsProvider>(context, listen: false).fetchUserToken();
          },
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  DashboardCard(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: walletCard(context),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SendReceiveAssetsRow(screenWidth: screenWidth),
                  const SizedBox(height: 5,),
                  const AssetsAndTrxTapbar(),
                  const SizedBox(height: 30,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



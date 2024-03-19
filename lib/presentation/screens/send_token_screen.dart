import 'package:flutter/material.dart';
import 'package:mindchain_wallet/presentation/provider/create_new_wallet_provider.dart';
import 'package:mindchain_wallet/presentation/provider/send_token_provider.dart';
import 'package:mindchain_wallet/presentation/screens/Qr_screen.dart';
import 'package:mindchain_wallet/presentation/screens/dashboard_screen.dart';
import 'package:mindchain_wallet/widget/backgroundwidget.dart';
import 'package:mindchain_wallet/widget/custom_popup.dart';
import 'package:mindchain_wallet/widget/gredient_background_bottom.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class SendToken extends StatefulWidget {
  const SendToken({Key? key}) : super(key: key);

  @override
  State<SendToken> createState() => _SendTokenState();
}

class _SendTokenState extends State<SendToken> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<SendTokenProvider>(context, listen: false).loadGesPrice();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Card(
              surfaceTintColor: Colors.transparent,
              shadowColor: Colors.transparent,
              color: const Color(0x35d2d2d2),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Consumer<SendTokenProvider>(
                  builder: (context, provider, child) => Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Send Your Funds",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 21,
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(
                              Icons.cancel,
                              color: Colors.red,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      InputDesign(
                        hintText: "Amount:",
                        inputType: TextInputType.number,
                        controller: provider.amountTEC,
                      ),
                      const SizedBox(height: 5),
                      Consumer<CreateWalletProvider>(
                        builder: (context, value, child) => Text(
                          " Your Balance ${value.mindBalance} MIND",
                          style: const TextStyle(
                            color: Color(0xffFF8A00),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        controller: provider.addressTEC,
                        decoration:    InputDecoration(
                          hintText: "Receiver Address...",
                          hintStyle: const TextStyle(fontSize: 12),
                          suffixIcon: InkWell(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => QrCodeScanScreen(),)),
                              child: const Icon(Icons.qr_code_2)),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(
                              color: Color(0xff959595),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.all(14),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff959595)),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Row(
                        children: [
                          Text("Gas Price (GWEI)"),
                          SizedBox(width: 5),
                          Icon(
                            Icons.info,
                            size: 18,
                          ),
                        ],
                      ),
                      InputDesign(
                        hintText: "10.9999999999",
                        inputType: TextInputType.text,
                        controller: provider.gesPriceTEC,
                      ),
                      const SizedBox(height: 5),
                      const Row(
                        children: [
                          Text("Gas Limit"),
                          SizedBox(width: 5),
                          Icon(
                            Icons.info,
                            size: 18,
                          )
                        ],
                      ),
                      InputDesign(
                        hintText: "10.9999999999",
                        inputType: TextInputType.text,
                        controller: provider.gesLimitTEC,
                      ),
                      const SizedBox(height: 20),
                      Consumer<SendTokenProvider>(
                        builder: (context, value, child) => GestureDetector(
                          onTap: () {
                            if (value.addressTEC.text != null &&
                                value.amountTEC.text != null) {
                              value.sendEth();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const DashboardScreen(),
                                  ),
                                  (route) => false);
                            }else{
                              customPopUp(context, "Erorr", const Text("Fill all input"));
                            }
                          },
                          child: const GredientBackgroundBtn(
                            child: Text(
                              "Send",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class InputDesign extends StatelessWidget {
  final TextInputType inputType;
  final String hintText;
  final TextEditingController controller;

  const InputDesign({
    Key? key,
    required this.hintText,
    required this.inputType,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        hintStyle: const TextStyle(fontSize: 13),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff959595),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff959595),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff959595),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        contentPadding: const EdgeInsets.all(14),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          borderSide: BorderSide(color: Color(0xff959595)),
        ),
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:patient/components/copyButton/copy_button.dart';
import 'package:patient/main.dart';
import 'package:patient/utils/eth_amount_formatter.dart';
import 'package:flutter/material.dart';
import 'package:patient/wallet_main.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

class Balance extends StatelessWidget {
  const Balance({
    Key? key,
    required this.address,
    required this.ethBalance,
    required this.tokenBalance,
  }) : super(key: key);

  final String? address;
  final BigInt? ethBalance;
  final String? tokenBalance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FirstRoute(),
            ),
          );
        },
        child: Container(
          color: Colors.yellow,
          child: Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Logout",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: ZStack(
        [
          VxBox()
              .blue600
              .size(context.screenWidth, context.percentHeight * 20)
              .make(),
          VStack([
            (context.percentHeight * 1).heightBox,
            'Wallet'.text.xl4.bold.white.center.makeCentered().py16(),
            Text(
              '${EthAmountFormatter(ethBalance).format()} eth',
              style: TextStyle(fontSize: 16),
            ).centered().shimmer(
                primaryColor: Colors.amber,
                secondaryColor: Colors.green,
                duration: Duration(seconds: 2)),
            (context.percentHeight * 1).heightBox,
            VxBox(
                child: VStack([
              'Account'.text.green800.bold.makeCentered(),
              10.heightBox,
              if (address != null)
                address!.text.bold.makeCentered().shimmer(
                      primaryColor: Colors.black,
                      secondaryColor: Colors.green,
                    )
              else
                const CircularProgressIndicator().centered(),
              CopyButton(
                text: const Text('Copy address'),
                value: address,
              ).centered(),
            ])).p8.gray300.rounded.shadow2xl.make().p16(),
            20.heightBox,
            VxBox(
                child: VStack([
              'Transaction ID'.text.green800.bold.size(18).makeCentered(),
              10.heightBox,
              if (address != null)
                keySender!.text.black.semiBold.makeCentered()
              else
                const CircularProgressIndicator().centered(),
              CopyButton(
                text: const Text('copy Tr_ID'),
                value: keySender,
              ).centered(),
            ])).p16.gray300.rounded.shadow2xl.make(),
            20.heightBox,
            if (address != null)
              // QrImage(
              //   data: address!,
              //   size: 150.0,
              // ),

              const SizedBox(
                height: 20,
              ),
          ]),
        ],
      ),
    );
  }
}

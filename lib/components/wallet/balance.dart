import 'package:patient/components/copyButton/copy_button.dart';
import 'package:patient/utils/eth_amount_formatter.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
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
    return SingleChildScrollView(
      child: ZStack(
        [
          VxBox()
              .blue600
              .size(context.screenWidth, context.percentHeight * 15)
              .make(),
          VStack([
            (context.percentHeight * 1).heightBox,
            'Wallet'.text.xl4.bold.white.center.makeCentered().py16(),
            (context.percentHeight * 1).heightBox,

            VxBox(
                    child: VStack([
              'Account'.text.gray700.semiBold.makeCentered(),
              10.heightBox,
              if (address != null)
                address!.text.bold.red100.makeCentered().shimmer()
              else
                const CircularProgressIndicator().centered(),
              CopyButton(
                text: const Text('Copy address'),
                value: address,
              ).centered(),
            ]))
                .p16
                .white
                .size(context.screenWidth, context.percentHeight * 20)
                .rounded
                .shadow2xl
                .make()
                .p16(),

            //20.heightBox,
            VxBox(
                    child: VStack([
              'Data'.text.gray700.bold.size(22).makeCentered(),
              10.heightBox,
              if (address != null)
                SingleChildScrollView(
                    child: tokenBalance!.text.semiBold.blue600.makeCentered())
              else
                const CircularProgressIndicator().centered(),
              // CopyButton(
              //   text: const Text('Copy address'),
              //   value: tokenBalance,
              // ).centered(),
            ]))
                .p16
                .gray300
                .size(context.screenWidth, context.percentHeight * 35)
                .rounded
                .shadow2xl
                .make(),
            20.heightBox,

            if (address != null)
              // QrImage(
              //   data: address!,
              //   size: 150.0,
              // ),

              const SizedBox(
                height: 20,
              ),
            Text(
              '${EthAmountFormatter(ethBalance).format()} eth',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  ?.apply(color: Colors.red),
            ).centered().shimmer(),

            Align(
              alignment: Alignment.center,
              child: Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text('Logout'),
                  onPressed: () {},
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}

import 'dart:async';
import 'dart:math';

import 'package:patient/context/transfer/wallet_transfer_state.dart';
import 'package:patient/model/wallet_transfer.dart';
import 'package:patient/service/configuration_service.dart';
import 'package:patient/service/contract_service.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:web3dart/credentials.dart';

class WalletTransferHandler {
  WalletTransferHandler(
    this._store,
    this._contractService,
    this._configurationService,
  );

  final Store<WalletTransfer, WalletTransferAction> _store;
  final ContractService _contractService;
  final ConfigurationService _configurationService;

  WalletTransfer get state => _store.state;

  Future<bool> transfer(String to, String amount, String amount2) async {
    final completer = Completer<bool>();
    final privateKey = _configurationService.getPrivateKey();

    _store.dispatch(WalletTransferStarted());

    try {
      await _contractService.send(
        privateKey!,
        EthereumAddress.fromHex(to),
        amount,
        amount2,
        onTransfer: (from, to, value, value2) {
          completer.complete(true);
        },
        onError: (ex) {
          _store.dispatch(WalletTransferError(ex.toString()));
          completer.complete(false);
        },
      );
    } catch (ex) {
      _store.dispatch(WalletTransferError(ex.toString()));
      completer.complete(false);
    }

    return completer.future;
  }
}

import 'dart:async';
import 'package:patient/wallet_main.dart';
import 'package:web3dart/web3dart.dart';

typedef TransferEvent = void Function(
  EthereumAddress from,
  EthereumAddress to,
  String value,
  String value2,
);

abstract class IContractService {
  Future<Credentials> getCredentials(String privateKey);
  Future<String?> send(String privateKey, EthereumAddress receiver,
      String amount, String amount2,
      {TransferEvent? onTransfer, Function(Object exeception)? onError});
  Future<String> getTokenBalance(EthereumAddress from);
  Future<EtherAmount> getEthBalance(EthereumAddress from);
  Future<void> dispose();
  StreamSubscription listenTransfer(TransferEvent onTransfer);
}

class ContractService implements IContractService {
  ContractService(this.client, this.contract);

  final Web3Client client;
  final DeployedContract contract;

  ContractEvent _transferEvent() => contract.event('Transfer');
  ContractFunction _balanceFunction() => contract.function('balanceOf');
  ContractFunction _sendFunction() => contract.function('transfer');

  @override
  Future<Credentials> getCredentials(String privateKey) =>
      client.credentialsFromPrivateKey(privateKey);

  @override
  Future<String?> send(String privateKey, EthereumAddress receiver,
      String amount, String amount2,
      {TransferEvent? onTransfer, Function(Object exeception)? onError}) async {
    final credentials = await getCredentials(privateKey);
    final from = await credentials.extractAddress();
    final networkId = await client.getNetworkId();

    StreamSubscription? event;
    // Workaround once sendTransacton doesn't return a Promise containing confirmation / receipt
    if (onTransfer != null) {
      event = listenTransfer((from, to, value, value2) async {
        onTransfer(from, to, value, value2);
        await event?.cancel();
      }, take: 1);
    }

    try {
      final transactionId = await client.sendTransaction(
        credentials,
        Transaction.callContract(
          contract: contract,
          function: _sendFunction(),
          parameters: [receiver, amount, amount2],
          from: from,
        ),
        chainId: networkId,
      );
      print('transact started $transactionId');
      keySender = transactionId;
      return transactionId;
    } catch (ex) {
      if (onError != null) {
        onError(ex);
      }
      return null;
    }
  }

  @override
  Future<EtherAmount> getEthBalance(EthereumAddress from) async {
    return client.getBalance(from);
  }

  @override
  Future<String> getTokenBalance(EthereumAddress from) async {
    final response = await client.call(
      contract: contract,
      function: _balanceFunction(),
      params: [from],
    );
    print(' Data2 $response');
    //return response as String;
    return response[0] + "\n" + response[1] as String;
  }

  @override
  StreamSubscription listenTransfer(TransferEvent onTransfer, {int? take}) {
    var events = client.events(FilterOptions.events(
      contract: contract,
      event: _transferEvent(),
    ));

    if (take != null) {
      events = events.take(take);
    }

    return events.listen((event) {
      if (event.topics == null || event.data == null) {
        return;
      }

      final decoded =
          _transferEvent().decodeResults(event.topics!, event.data!);

      final from = decoded[0] as EthereumAddress;
      final to = decoded[1] as EthereumAddress;
      final value = decoded[2] as String;
      final value2 = decoded[3] as String;

      print('$from}');
      print('$to}');
      print('$value}');
      print('$value2}');

      onTransfer(from, to, value, value2);
    });
  }

  @override
  Future<void> dispose() async {
    await client.dispose();
  }
}

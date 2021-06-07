class AppConfig {
  AppConfig() {
    params['dev'] = AppConfigParams(
        'http://192.168.137.1:7545',
        'ws://192.168.137.1:7545',
        '0x578EB2e9607461b21C210dA0755848c416AA5443');

    params['ropsten'] = AppConfigParams(
        'https://ropsten.infura.io/v3/628074215a2449eb960b4fe9e95feb09',
        'wss://ropsten.infura.io/ws/v3/628074215a2449eb960b4fe9e95feb09',
        '0xB2f428e6D1A0D8bdbf8f94371AE20Be8F7eFca4a');
  }

  Map<String, AppConfigParams> params = <String, AppConfigParams>{};
}

class AppConfigParams {
  AppConfigParams(this.web3HttpUrl, this.web3RdpUrl, this.contractAddress);
  final String web3RdpUrl;
  final String web3HttpUrl;
  final String contractAddress;
}

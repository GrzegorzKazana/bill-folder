import 'dart:collection';

import 'package:bill_folder/common/state/async_state.dart';

import '../models/Wallet.dart';
import '../models/Currency.dart';

import '_mocks.dart';

class WalletState extends AsyncState<List<Wallet>> {
  Wallet _currentWallet;

  WalletState() : super([]);

  Wallet get currentWallet => _currentWallet;
  String get currentWalletId => _currentWallet?.id;
  UnmodifiableListView<Wallet> get wallets => UnmodifiableListView(data);
  Currency get currentWalletCurrency => _currentWallet?.currency;

  Future<bool> loadWallets() {
    initFetch();

    return Future.value(mockWallets).then((wallets) {
      _currentWallet = wallets.isNotEmpty ? wallets.first : null;
      dataLoaded(wallets);

      return wallets.isNotEmpty;
    }).catchError(requestError);
  }

  void changeCurrentWallet(String walletId) {
    if (_currentWallet != null && _currentWallet.id == walletId) return;

    final wallet =
        data.firstWhere((wallet) => wallet.id == walletId, orElse: () => null);

    if (wallet == null) return;

    _currentWallet = wallet;
    notifyListeners();
  }

  void addWallet(Wallet wallet) {
    _currentWallet = wallet;
    setData([...data, wallet]);
  }
}

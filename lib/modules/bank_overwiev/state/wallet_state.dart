import 'dart:collection';

import 'package:bill_folder/common/state/async_state.dart';

import '../models/Wallet.dart';
import '../models/Currency.dart';

import '_mocks.dart';

class WalletState extends AsyncState<List<Wallet>> {
  Wallet _currentWallet;

  Wallet get currentWallet => _currentWallet;
  UnmodifiableListView<Wallet> get wallets => UnmodifiableListView(data);
  Currency get currentWalletCurrency => _currentWallet?.currency;

  void loadWallets() {
    initFetch();
    Future.value(mockWallets).then(dataLoaded).catchError(requestError);
  }

  void changeCurrentWallet(String walletId) {
    if (_currentWallet.id == walletId) return;

    final wallet =
        data.firstWhere((wallet) => wallet.id == walletId, orElse: () => null);

    if (wallet == null) return;

    _currentWallet = wallet;
    notifyListeners();
  }
}

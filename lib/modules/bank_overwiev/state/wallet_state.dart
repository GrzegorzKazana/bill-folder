import 'dart:collection';

import 'package:bill_folder/common/state/async_state.dart';

import '../services/wallet_repository.dart';
import '../models/Wallet.dart';
import '../models/Currency.dart';

class WalletState extends AsyncState<List<Wallet>> {
  final WalletRepository repo;
  WalletState(this.repo) : super([]);

  Wallet _currentWallet;

  Wallet get currentWallet => _currentWallet;
  String get currentWalletId => _currentWallet?.id;
  UnmodifiableListView<Wallet> get wallets => UnmodifiableListView(data);
  Currency get currentWalletCurrency => _currentWallet?.currency;

  void loadWallets() {
    initFetch();

    repo.getAll().then(dataLoaded).then((wallets) {
      _currentWallet = wallets.isNotEmpty ? wallets.first : null;
    }).catchError(requestError);
  }

  void changeCurrentWallet(Wallet wallet) {
    if (_currentWallet == wallet) return;
    _currentWallet = wallet;
    notifyListeners();
  }

  void addWallet(Wallet wallet) {
    repo.insert(wallet).then((_) {
      _currentWallet = wallet;
      setData([...data, wallet]);
    }).catchError(requestError);
  }
}

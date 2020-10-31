import 'dart:collection';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:bill_folder/common/state/async_state.dart';

import '../services/wallet_repository.dart';
import '../models/Wallet.dart';
import '../models/Currency.dart';

class WalletState extends AsyncState<List<Wallet>> {
  final WalletRepository repo;
  final SharedPreferences prefs;
  WalletState(this.repo, this.prefs) : super([]);

  static String get currentWalletKey => 'current_wallet_key';

  Wallet _currentWallet;

  Wallet get currentWallet => _currentWallet;
  String get currentWalletId => _currentWallet?.id;
  UnmodifiableListView<Wallet> get wallets => UnmodifiableListView(data);
  Currency get currentWalletCurrency => _currentWallet?.currency;

  void loadWallets() {
    final currentWalletId = prefs.getString(currentWalletKey);

    initFetch();
    repo.getAll().then(dataLoaded).then((wallets) {
      if (wallets.isEmpty) return;

      _currentWallet =
          (_getWalletById(currentWalletId, wallets) ?? wallets.last);
    }).catchError(requestError);
  }

  void changeCurrentWallet(Wallet wallet) {
    if (_currentWallet == wallet) return;

    _currentWallet = wallet;
    prefs.setString(currentWalletKey, wallet.id);
    notifyListeners();
  }

  void addWallet(Wallet wallet) {
    repo.insert(wallet).then((_) {
      _currentWallet = wallet;
      setData([...data, wallet]);
    }).catchError(requestError);
  }

  Wallet _getWalletById(String currentWalletId, List<Wallet> wallets) {
    return wallets.firstWhere((w) => w.id == currentWalletId,
        orElse: () => null);
  }
}

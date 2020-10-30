import 'package:flutter/material.dart';

enum AsyncStatus {
  IDLE,
  PENDING,
  LOADED,
  ERROR,
}

class AsyncState<T> extends ChangeNotifier {
  AsyncStatus _status = AsyncStatus.IDLE;
  T _data;
  Object _error;

  AsyncStatus get status => _status;
  T get data => _data;
  Error get error => _error;

  void initFetch() {
    _status = AsyncStatus.PENDING;
    _error = null;
    notifyListeners();
  }

  void dataLoaded(T data) {
    _status = AsyncStatus.LOADED;
    _data = data;
    notifyListeners();
  }

  void requestError(Object error) {
    _status = AsyncStatus.ERROR;
    _error = error;
    notifyListeners();
  }

  void setStatus(AsyncStatus status) {
    _status = status;
    notifyListeners();
  }

  void setData(T data) {
    _data = data;
    notifyListeners();
  }
}

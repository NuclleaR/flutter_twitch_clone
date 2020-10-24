import 'package:flutter/cupertino.dart';
import 'package:twitch_clone/constants/auth.dart';


class AuthState with ChangeNotifier {
  AuthStatus _status = AuthStatus.notAuthenticated;

  AuthState();

  AuthState.withStatus(AuthStatus status) : this._status = status;

  AuthStatus get status => _status;

  void login() {
    _status = AuthStatus.authenticated;
    notifyListeners();
  }

  void logout() {
    print('logout');
    _status = AuthStatus.notAuthenticated;
    notifyListeners();
  }
}

import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:twitch_clone/models/token.dart';

class TokenStorage {
  final FlutterSecureStorage _storage = new FlutterSecureStorage();
  final String tokenKey;

  TokenStorage(this.tokenKey);



  Future<void> write(Token token) {
    return _storage.write(key: this.tokenKey, value: jsonEncode(token));
  }

  Future<Token> read() async {
    String value = await _storage.read(key: this.tokenKey);
    if (value != null) {
      return Token.fromJson(jsonDecode(value));
    }
    return null;
  }

  Future<void> deleteToken() {
    return _storage.delete(key: this.tokenKey);
  }
}

import 'package:twitch_clone/auth/auth.dart';
import 'package:twitch_clone/models/models.dart';
import 'package:twitch_clone/services/storage.dart';


class TokenManager {
  final String name;
  final Oauth2Client _client;
  final TokenStorage _storage;

  Token _token;
  int _secondsToExpiration = 30;

  static final Map<String, TokenManager> _cache = <String, TokenManager>{};

  factory TokenManager(
      {String name, Oauth2Client client, TokenStorage storage}) {
    return _cache.putIfAbsent(
        name,
        () => TokenManager._internal(
            name: name, client: client, storage: storage));
  }

  TokenManager._internal(
      {String name, Oauth2Client client, TokenStorage storage})
      : this.name = name,
        this._client = client,
        this._storage = storage;

  Future<void> getToken() async {
    await _readToken();

    if (_token == null) {
      await authenticate();
    } else if (needRefresh) {
      await refreshToken();
    }
  }

  Future<void> getTokenFromStorage() async {
    await _readToken();
    if(needRefresh) {
      await refreshToken();
    }
  }

  Future<bool> authenticate() async {
    Map<String, dynamic> tokenResponse = await this._client.authenticate();
    _token = Token.fromJson(tokenResponse);
    _storage.write(_token);
    return true;
  }

  // Performs a refresh_token request using the [refreshToken].
  Future<void> refreshToken() async {
    Map<String, dynamic> tokenResponse;

    try {
      tokenResponse = await this._client.refreshToken(_token.refreshToken);
    } catch (_) {
      return await authenticate();
    }

    if (tokenResponse == null) {
      throw OAuth2Exception('Unexpected error');
    } else if (tokenResponse.containsKey('error')) {
      if (tokenResponse['error'] == 'invalid_grant') {
        //The refresh token is expired too
        await _storage.deleteToken();
        //Fetch another access token
        return await authenticate();
      } else {
        throw OAuth2Exception(tokenResponse['error'],
            errorDescription: "Invalid token");
      }
    } else {
      //If the response doesn't contain a refresh token, keep using the current one
      if (!tokenResponse.containsKey('refresh_token')) {
        tokenResponse['refresh_token'] = _token.refreshToken;
      }
      _token = Token.fromJson(tokenResponse);
      await _storage.write(_token);
    }
  }

  Future<void> logOut() async {
    await _storage.deleteToken();
  }

  Future<void> _readToken() async {
    _token = await _storage.read();
  }

  Map<String, String> getHeaders() {
    return {'Authorization': 'Bearer $token', 'Client-Id': _client.clientId};
  }

  set secondsToExpiration(int value) {
    _secondsToExpiration = value;
  }

  String get token => _token?.accessToken;

  bool get isExpired => _token?.isExpired() ?? true;

  bool get needRefresh {
    bool needsRefresh = false;

    if (_token?.expirationDate != null) {
      var now = DateTime.now();
      needsRefresh = _token.expirationDate.difference(now).inSeconds <
          _secondsToExpiration;
    }

    return needsRefresh;
  }
}

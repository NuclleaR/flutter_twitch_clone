import 'dart:convert';
import 'package:http/http.dart';

import 'package:flutter_web_auth/flutter_web_auth.dart';

abstract class Oauth2Client {
  final String clientId;
  final String clientSecret;
  final String callbackUrlScheme;
  final String scopes;

  final String authUrl;
  final String tokenUrl;
  final String revokeUrl;

  Oauth2Client(
      {this.clientId,
      this.clientSecret,
      this.callbackUrlScheme,
      this.scopes,
      this.authUrl,
      this.revokeUrl,
      this.tokenUrl});

  String getAuthUrl() {
    return Uri.parse(this.authUrl).replace(queryParameters: {
      'client_id': this.clientId,
      'redirect_uri': '${this.callbackUrlScheme}:/oauth2redirect',
      'scope': this.scopes,
      'response_type': 'code',
    }).toString();
  }

  Future<Map<String, dynamic>> authenticate() async {
    String result = await FlutterWebAuth.authenticate(
        url: getAuthUrl(), callbackUrlScheme: callbackUrlScheme);
    print(getAuthUrl());
    String code = Uri.parse(result).queryParameters['code'];
    print(code);
    return await _getToken(code);

  }

  // Refreshes an Access Token issuing a refresh_token grant to the OAuth2 server.
  Future<Map<String, dynamic>> refreshToken(String refreshToken) async {
    final Map params = _getRefreshUrlParams(refreshToken);
    final response = await _performAuthorizedRequest(params);
    return jsonDecode(response.body);
  }

  Future<Response> revokeToken(String token) {
    return post('$revokeUrl?client_id=$clientId&token=$token');
  }

  Future<Map<String, dynamic>> _getToken(String code) async {
    final params = <String, String>{
      'client_id': this.clientId,
      'redirect_uri': '${this.callbackUrlScheme}:/oauth2redirect',
      'grant_type': 'authorization_code',
      'code': code,
    };

    if (this.clientSecret != null) {
      params['client_secret'] = this.clientSecret;
    }

    final response = await _performAuthorizedRequest(params);
    print(this.callbackUrlScheme);
    return jsonDecode(response.body);
  }

  Future<Response> _performAuthorizedRequest(Map<String, dynamic> params) {
    return post(tokenUrl, body: params);
  }

  Map<String, String> _getRefreshUrlParams(String refreshToken) {
    final params = <String, String>{
      'grant_type': 'refresh_token',
      'refresh_token': refreshToken
    };

    if (clientSecret == null || clientSecret.isEmpty) {
      if (clientId != null && clientId.isNotEmpty) {
        params['client_id'] = clientId;
      }
    }
    if (clientId != null && clientId.isNotEmpty) {
      params['client_id'] = clientId;
    }
    if (clientSecret != null && clientSecret.isNotEmpty) {
      params['client_secret'] = clientSecret;
    }

    return params;
  }
}

// POST https://id.twitch.tv/oauth2/revoke
//     ?client_id=<your client ID>
//     &token=<your OAuth token>
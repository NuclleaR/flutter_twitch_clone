import 'dart:async';
import 'dart:convert';
// import 'package:uni_links/uni_links.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart';

@deprecated
class GoogleClient {
  final String _authUrl = "https://accounts.google.com/o/oauth2/v2/auth";
  final String _tokenUrl = "https://oauth2.googleapis.com/token";
  final String _redirectUri = "com.example.twitchClone:/oauth2redirect";
  final String _clientId;

  String _scopes = "email profile";

  StreamSubscription<Uri> _sub;

  GoogleClient(clientId) : _clientId = clientId;

  Future<void> login(Function(Map<String, Object>) successCb) async {
    String authUrl = Uri.parse(_authUrl).replace(queryParameters: {
      'scope': _scopes,
      'response_type': 'code',
      'redirect_uri': _redirectUri,
      'client_id': _clientId,
    }).toString();

    // if (await canLaunch(authUrl)) {
    //   _subscribe(successCb);
    //   launch(authUrl);
    // } else {
    //   throw 'Could not launch $authUrl';
    // }
  }

  Future<Map<String, Object>> _fetchToken(String code) async {
    Map<String, String> params = {
      'code': code,
      'client_id': _clientId,
      'grant_type': 'authorization_code',
      'redirect_uri': _redirectUri,
    };

    try {
      Response response = await post(_tokenUrl, body: params);
      Map<String, Object> responseBody = jsonDecode(response.body);
      return responseBody;
    } catch (err) {
      print('Caught error: $err');
      throw err;
    } finally {
      // closeWebView();
    }
  }

  _subscribe(Function(Map<String, Object>) successCb) {
    // _sub = getUriLinksStream().listen((Uri link) {
    //   _fetchToken(link.queryParameters['code']).then(successCb);
    //   _sub.cancel();
    // }, onError: (err) {
    //   print('Err:');
    //   print(err);
    // });
  }

  set scopes(String value) {
    _scopes = value;
  }
}

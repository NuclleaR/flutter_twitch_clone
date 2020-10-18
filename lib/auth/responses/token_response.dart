import 'oauth2_response.dart';

class TokenResponse extends OAuth2Response {
  String accessToken;
  String tokenType;
  int expiresIn;
  String refreshToken;
  List<String> scope;

  DateTime expirationDate;

  TokenResponse.fromMap(Map<String, dynamic> map) : super.fromMap(map) {
    accessToken = map['access_token'];
    // Some providers (e.g. Slack) don't return the token_type parameter, even if it's required...
    // In those cases, fallback to "bearer"
    tokenType = map['token_type'] ?? 'Bearer';
    if (map.containsKey('refresh_token')) refreshToken = map['refresh_token'];

    if (map.containsKey('scope')) {
      if (map['scope'] is List) {
        List scopesJson = map['scope'];
        scope = List.from(scopesJson);
      } else {
        //The OAuth 2 standard suggests that the scopes should be a space-separated list,
        //but some providers (i.e. GitHub) return a comma-separated list
        scope = map['scope']?.split(RegExp(r'[\s,]'));
      }

      scope = scope?.map((s) => s.trim())?.toList();
    }

    if (map.containsKey('expires_in')) {
      try {
        expiresIn = map['expires_in'] is String
            ? int.parse(map['expires_in'])
            : map['expires_in'];
      } on FormatException {
        //Provide a fallback value if the expires_in parameter is not an integer...
        expiresIn = 60;
        //...But rethrow the exception!
        rethrow;
      }
    }
  }
}

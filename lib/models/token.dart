class Token {
  String accessToken;
  String tokenType;
  int expiresIn;
  String refreshToken;
  List<String> scope;

  DateTime expirationDate;

  bool isExpired() {
    var expired = false;

    if (expirationDate != null) {
      var now = DateTime.now();
      expired = expirationDate.difference(now).inSeconds < 0;
    }

    return expired;
  }

  // Checks if the access token must be refreeshed
  bool refreshNeeded({secondsToExpiration = 30}) {
    var needsRefresh = false;

    if (expirationDate != null) {
      var now = DateTime.now();
      needsRefresh =
          expirationDate.difference(now).inSeconds < secondsToExpiration;
    }

    return needsRefresh;
  }

  // Checks if the refresh token has been returned by the server
  bool hasRefreshToken() {
    return refreshToken != null;
  }

  // Checks if the token is a "Bearer" token
  bool isBearer() {
    return tokenType.toLowerCase() == 'bearer';
  }

  Map<String, dynamic> toJson () => {
    'access_token': accessToken,
    'token_type': tokenType,
    'expires_in': expiresIn,
    'refresh_token': refreshToken,
    'scope': scope,
    'expiration_date': expirationDate.millisecondsSinceEpoch,
  };

  Token.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    // Some providers (e.g. Slack) don't return the token_type parameter, even if it's required...
    // In those cases, fallback to "bearer"
    tokenType = json['token_type'] ?? 'Bearer';
    if (json.containsKey('refresh_token')) refreshToken = json['refresh_token'];

    if (json.containsKey('scope')) {
      if (json['scope'] is List) {
        List scopesJson = json['scope'];
        scope = List.from(scopesJson);
      } else {
        // The OAuth 2 standard suggests that the scopes should be a space-separated list,
        // but some providers (i.e. GitHub) return a comma-separated list
        scope = json['scope']?.split(RegExp(r'[\s,]'));
      }

      scope = scope?.map((s) => s.trim())?.toList();
    }

    if (json.containsKey('expires_in')) {
      try {
        expiresIn = json['expires_in'] is String
            ? int.parse(json['expires_in'])
            : json['expires_in'];
      } on FormatException {
        // Provide a fallback value if the expires_in parameter is not an integer...
        expiresIn = 60;
        // ...But rethrow the exception!
        rethrow;
      }
    }


    expirationDate = null;

    if (json.containsKey('expiration_date') &&
        json['expiration_date'] != null) {
      expirationDate =
          DateTime.fromMillisecondsSinceEpoch(json['expiration_date']);
    } else {
      if (expiresIn != null) {
        var now = DateTime.now();
        expirationDate = now.add(Duration(seconds: expiresIn));
      }
    }
  }
}

class OAuth2Response {
  String error;
  String errorDescription;
  String errorUri;

  OAuth2Response.fromMap(Map<String, dynamic> map) {
    if (map.containsKey('error') && map['error'] != null) {
      error = map['error'];
      errorDescription = map.containsKey('error_description')
          ? map['error_description']
          : null;
      errorUri = map.containsKey('errorUri') ? map['errorUri'] : null;
    }
  }
}

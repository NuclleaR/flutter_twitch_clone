import 'oauth2_client.dart';

class GoogleClient extends Oauth2Client {
  String authUrl = "https://accounts.google.com/o/oauth2/v2/auth";
  String tokenUrl = "https://oauth2.googleapis.com/token";

  GoogleClient(
      {String clientId,
      String clientSecret,
      String callbackUrlScheme,
      String scopes})
      : super(
            clientId: clientId,
            clientSecret: clientSecret,
            callbackUrlScheme: callbackUrlScheme,
            scopes: scopes);
}

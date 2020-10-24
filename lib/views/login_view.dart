import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:social_buttons/social_buttons.dart';
import 'package:twitch_clone/models/models.dart';
import 'package:twitch_clone/services/services.dart';

class LoginView extends StatelessWidget {
  final TokenManager tokenManager =
      getManager(TokenManagerType.twitchTokenManager);

  _handlePress(AuthState authState) async {
    print('Twitch clicked');
    bool authenticated = await tokenManager.authenticate();
    if (authenticated) {
      authState.login();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      // color: CupertinoColors.systemBackground,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
            CupertinoColors.systemTeal,
            CupertinoColors.systemPink
          ])),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CupertinoSocialButton(
                button: Buttons.Twitch,
                onPressed: (_) {
                  _handlePress(context.read<AuthState>());
                },
                textAlignment: TextAlignment.center,
                label: "Sign in with Twitch",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

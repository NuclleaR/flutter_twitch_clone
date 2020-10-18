import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:twitch_clone/constants/auth.dart';

import 'main_app.dart';
import 'models/auth.dart';
import 'services/manager_factory.dart';
import 'services/token_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AuthStatus authStatus = AuthStatus.notAuthenticated;

  final TokenManager tokenManager = getManager(TokenManagerType.twitchTokenManager);

  await tokenManager.getTokenFromStorage();

  if (tokenManager.token != null && tokenManager.token.isNotEmpty) {
    authStatus = AuthStatus.authenticated;
  }

  runApp(MyApp(authStatus));
}

class MyApp extends StatelessWidget {
  final AuthStatus authStatus;
  MyApp(this.authStatus);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Flutter Demo',
      home: ChangeNotifierProvider(
        create: (context) => AuthState.withStatus(authStatus),
        child: MainApp(this.authStatus),
      ),
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:twitch_clone/constants/auth.dart';
import 'package:twitch_clone/store/states.dart';

import 'blocs/blocs.dart';
import 'main_app.dart';
import 'models/models.dart';
import 'services/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AuthStatus authStatus = AuthStatus.notAuthenticated;

  final TokenManager tokenManager =
      getManager(TokenManagerType.twitchTokenManager);

  await tokenManager.getTokenFromStorage();
  print(tokenManager.token);
  if (tokenManager.token != null && tokenManager.token.isNotEmpty) {
    if (!tokenManager.isExpired) {
      authStatus = AuthStatus.authenticated;
    }
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
      theme: CupertinoThemeData(),
        title: 'Flutter Demo',
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider.value(
                value: AuthState.withStatus(authStatus)),
            ChangeNotifierProvider.value(value: AppSate()),
            Provider.value(value: GameBloc()),
          ],
          child: MainApp(this.authStatus),
        ));
  }
}

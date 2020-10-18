import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/auth.dart';
import '../services/manager_factory.dart';
import '../services/token_manager.dart';

class MainView extends StatelessWidget {

  final TokenManager tokenManager = getManager(
      TokenManagerType.twitchTokenManager);

  MainView();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.systemBackground,
      child: Center(
        child: CupertinoButton(
          color: CupertinoColors.link,
          child: Text("Log out"),
          onPressed: () {
            tokenManager.logOut();
            context.read<AuthState>().logout();
          },
        ),
      ),
    );
  }
}
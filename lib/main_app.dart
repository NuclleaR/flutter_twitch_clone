import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'blocs/blocs.dart';
import 'constants/auth.dart';
import 'models/auth_state.dart';
import 'views/login_view.dart';
import 'views/main_view.dart';

class MainApp extends StatelessWidget {
  final AuthStatus authStatus;

  MainApp(this.authStatus);

  @override
  Widget build(BuildContext context) {

    return context.watch<AuthState>().status == AuthStatus.authenticated
        ? MainView()
        : LoginView();
  }
}


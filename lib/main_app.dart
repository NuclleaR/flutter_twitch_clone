import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'constants/auth.dart';
import 'models/auth.dart';
import 'views/login_view.dart';
import 'views/main_view.dart';

class MainApp extends StatefulWidget {
  final AuthStatus authStatus;

  MainApp(this.authStatus);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

  @override
  Widget build(BuildContext context) {
    print(context.watch<AuthState>().status);
    return context.watch<AuthState>().status == AuthStatus.authenticated
        ? MainView()
        : LoginView();
  }
}

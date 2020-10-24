import 'package:flutter/cupertino.dart';
import 'package:twitch_clone/theme/theme.dart';

class AppSate with ChangeNotifier {
  // Values
  Theme _theme = Theme.light();
  int activeTab = 0;

  // Getters
  Theme get theme => _theme;

  // Methods
  void changeTheme(ThemeType themeType) {
    if(themeType == null) {
      throw 'ThemeType should be provided';
    }

    switch(themeType) {
      case ThemeType.DARK:
        _theme = Theme.dark();
        break;
      case ThemeType.LIGHT:
        _theme = Theme.light();
    }
    notifyListeners();
  }
}
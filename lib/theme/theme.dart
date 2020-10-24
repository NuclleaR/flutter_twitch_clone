import 'package:flutter/cupertino.dart';

enum ThemeType { DARK, LIGHT }

// TODO move to native theme
class Theme /* extends CupertinoThemeData */ {
  final ThemeType type;

  final Color primary = Color.fromARGB(255, 145, 70, 255);
  final Color background;
  final Color toolbar;
  final Color text;

  Theme._({this.type, this.background, this.toolbar, this.text});

  factory Theme.light() {
    return Theme._(
        type: ThemeType.LIGHT,
        background: CupertinoColors.systemBackground.color,
        toolbar: CupertinoColors.secondarySystemBackground.color,
        text: CupertinoColors.label.color);
  }

  factory Theme.dark() {
    return Theme._(
        type: ThemeType.DARK,
        background: CupertinoColors.systemBackground.darkColor,
        toolbar: CupertinoColors.secondarySystemBackground.darkColor,
        text: CupertinoColors.label.darkColor);
  }
}

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:twitch_clone/models/models.dart';
import 'package:twitch_clone/store/states.dart';
import 'package:twitch_clone/theme/theme.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appSate = context.watch<AppSate>();

    return CupertinoPageScaffold(
      child: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Light"),
                CupertinoSwitch(
                  activeColor: appSate.theme.primary,
                  value: appSate.theme.type == ThemeType.DARK,
                  onChanged: (value) {
                    appSate.changeTheme(value ? ThemeType.DARK : ThemeType.LIGHT);
                  },
                ),
                Text("Dark"),
              ],
            ),
            CupertinoButton(
              child: Text('Log out'),
              onPressed: () {
                context.read<AuthState>().logout();
              },
            )
          ],
        ),
      ),
    );
  }
}

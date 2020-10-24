import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:twitch_clone/blocs/blocs.dart';
import 'package:twitch_clone/models/models.dart';
import 'package:twitch_clone/services/services.dart';
import 'package:twitch_clone/store/states.dart';
import 'package:twitch_clone/views/views.dart';

import 'games/games_view.dart';

class MainView extends StatelessWidget {
  final TokenManager tokenManager =
      getManager(TokenManagerType.twitchTokenManager);

  @override
  Widget build(BuildContext context) {
    if (tokenManager.isExpired) {
      context.read<AuthState>().logout();
    }

    // context.read<GameBloc>().fetchTopGames();
    var theme = context.watch<AppSate>().theme;

    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        onTap:(value) {
          context.read<AppSate>().activeTab = value;
        },
        backgroundColor: theme.toolbar,
        activeColor: theme.primary,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home), label: "Games"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.heart), label: "Following"),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.gear),
            label: "Settings",
          )
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 1:
            return Center(child: Text("Following"));
          case 2:
            return Settings();
          case 0:
          default:
            return GamesView();
        }
      },
    );
  }
}

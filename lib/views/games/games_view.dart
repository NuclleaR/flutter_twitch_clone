import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:twitch_clone/blocs/blocs.dart';
import 'package:twitch_clone/store/states.dart';
import 'package:twitch_clone/views/views.dart';

import 'components/games_grid.dart';

class GamesView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return CupertinoTabView(
      builder: (BuildContext context) {
        var theme = context.watch<AppSate>().theme;
        return CupertinoPageScaffold(
          child: GamesGrid(),
          backgroundColor: theme.background,
        );
      },
      routes: <String, WidgetBuilder>{
        StreamsListView.routeName: (BuildContext context) {
          return StreamsListView();
        },
        // '/channel': () => ,
      },
    );
  }
}

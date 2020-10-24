import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import 'package:twitch_clone/models/models.dart';
import 'package:twitch_clone/store/states.dart';
import 'package:twitch_clone/widgets/widgets.dart';


class StreamsListView extends StatelessWidget {
  static const routeName = '/streams-list';

  @override
  Widget build(BuildContext context) {
    final Game game = ModalRoute.of(context).settings.arguments;

    var theme = context.watch<AppSate>().theme;

    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
              pinned: true,
              delegate: GamePageHeader(game)),
          SliverPersistentHeader(
              pinned: true,
              delegate: TabsHeader()),
          SliverFillRemaining(
              child: Container(
                decoration: BoxDecoration(
                  color: CupertinoColors.systemPink
                ),
                child: Text("Hello"),
              ))
        ],
      ),
    );
  }
}

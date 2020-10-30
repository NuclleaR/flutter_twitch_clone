import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:twitch_clone/blocs/blocs.dart';

import 'package:twitch_clone/models/models.dart';
import 'package:twitch_clone/store/states.dart';
import 'package:twitch_clone/widgets/widgets.dart';

import 'components/game_header_delegate.dart';
import 'components/stream_item.dart';

class StreamsListView extends StatelessWidget {
  static const routeName = '/streams-list';

  @override
  Widget build(BuildContext context) {
    final Game game = ModalRoute.of(context).settings.arguments;
    var theme = Provider.of<AppSate>(context, listen: false).theme;
    Provider.of<StreamsBloc>(context, listen: false).fetchStreams(game);

    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(pinned: true, delegate: GamePageHeader(game)),
          SliverPersistentHeader(pinned: true, delegate: TabsHeader()),
          StreamBuilder(
            stream: Provider.of<StreamsBloc>(context, listen: false).streams,
            builder: (_, AsyncSnapshot<List<GameStream>> snapshot) {
              if (snapshot.hasData) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext ctx, int index) {
                      return StreamItem(
                        key: Key(index.toString()),
                        stream: snapshot.data[index],
                      );
                    },
                    childCount: snapshot.data.length,
                  ),
                );
              } else {
                return SliverFillRemaining(
                    child: Container(
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(color: theme.background),
                  child: Text("No data"),
                ));
              }
            },
          ),
        ],
      ),
    );
  }
}

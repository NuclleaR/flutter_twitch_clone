import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:twitch_clone/blocs/blocs.dart';
import 'package:twitch_clone/models/models.dart';
import 'package:twitch_clone/store/app_state.dart';
import 'package:twitch_clone/widgets/widgets.dart';

class GamesGrid extends StatelessWidget {
  void _handleTap(Game game, BuildContext context) {
    Navigator.pushNamed(context, '/streams-list', arguments: game);
  }

  List<Widget> _getGamesList(List<Game> list, BuildContext context) {
    return list
        .map((game) => GaveCover(
              key: Key(game.id.toString()),
              game: game,
              onTap: (game) {
                _handleTap(game, context);
              },
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    if(Provider.of<AppSate>(context).activeTab == 0) {
      Provider.of<GameBloc>(context).fetchTopGames();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: StreamBuilder(
        stream: Provider.of<GameBloc>(context).games,
        builder: (_, AsyncSnapshot<List<Game>> snapshot) {
          if (snapshot.hasError) {
            Provider.of<AuthState>(context).logout();
          }
          if (snapshot.hasData) {
            return GridView.count(
              crossAxisCount: 2,
              primary: false,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.75,
              children: _getGamesList(snapshot.data, context),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          return Center(child: CupertinoActivityIndicator());
        },
      ),
    );
  }
}

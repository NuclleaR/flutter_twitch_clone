import 'package:flutter/cupertino.dart';
import 'package:twitch_clone/models/models.dart';

class GaveCover extends StatelessWidget {
  final Game _game;
  final void Function(Game game) _onTap;

  const GaveCover(
      {@required Key key, Game game, @required void Function(Game game) onTap})
      : this._onTap = onTap,
        this._game = game;

  void _handleTap() {
    _onTap(_game);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        child: Image.network(this._game.box.large),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:twitch_clone/models/models.dart';

class GamePageHeader extends SliverPersistentHeaderDelegate {
  final Game game;

  final double _height = 180.0;

  GamePageHeader(this.game);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      children: [
        Container(
          height: _height,
          alignment: AlignmentDirectional.bottomStart,
          // padding: EdgeInsets.symmetric(horizontal: 16.0),
          padding: EdgeInsets.only(
              bottom: 16.0,
              left: 16.0,
              right: 16.0
          ),
          // decoration: BoxDecoration(
          //   color: CupertinoColors.systemGreen,
          // ),
          child: Row(
            children: [
              Image.network(game.box.medium, width: 52, height: 72),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                height: 72.0,
                // decoration: BoxDecoration(
                //   color: CupertinoColors.systemYellow,
                // ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(game.name,
                        style: TextStyle(fontWeight: FontWeight.w800)),
                    Text('Active channels: ${game.channels}'),
                    Text('Viewers: ${game.viewers}'),
                  ],
                ),
              )
            ],
          ),
        ),
        CupertinoNavigationBar(
            backgroundColor: CupertinoColors.systemBackground,
            border: null,
            // TODO implement
            // brightness: ,
            middle: AnimatedOpacity(
              child: Text(game.name),
              duration: Duration(milliseconds: 200),
              opacity: shrinkOffset + 92 > _height ? 1 : 0,
            )),
      ],
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    print(oldDelegate);
    return true;
  }

  @override
  double get maxExtent {
    return _height;
  }

  @override
  double get minExtent {
    return 92;
  }
}

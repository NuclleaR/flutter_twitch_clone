import 'package:flutter/cupertino.dart';
import 'package:twitch_clone/models/models.dart';
import 'package:twitch_clone/widgets/widgets.dart';

class StreamItem extends StatelessWidget {
  final GameStream stream;

  final Color color = Color.fromARGB(255, 145, 70, 255);

  StreamItem({this.stream, Key key}) : super(key: key);

  List<Widget> _getTags(List<Tag> tags) {
    return tags.map((Tag tag) =>
        Padding(
          padding: const EdgeInsets.only(top: 4.0, right: 4.0),
          child: TagChip(
            key: Key(tag.tagId),
            tag: tag.name,
            color: color,
            labelColor: CupertinoColors.label.darkColor,
          ),
        )).toList();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Column(
      children: <Widget>[
        Stack(
          children: [
            Container(
              child: Image.network(stream.thumbnailUrl),
              width: width,
            ),
            Positioned(
              left: 10,
              top: 10,
              child: Badge(
                color: CupertinoColors.systemRed.color,
                labelColor: CupertinoColors.label.darkColor,
                label: 'Live',
              ),
            ),
            Positioned(
              bottom: 16.0,
              left: 16.0,
              child: Badge(
                color: Color.fromRGBO(0, 0, 0, 0.5),
                labelColor: CupertinoColors.label.darkColor,
                label: '${stream.viewerCount} viewers',
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 24.0, top: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CircularImage(
                  stream.user.profileImageUrl,
                  // TODO Move to theme
                  borderColor: color,
                  width: 68.0,
                  height: 68.0,
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(stream.user.displayName),
                      Text(stream.title),
                      Wrap(
                        children: _getTags(stream.tagList),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

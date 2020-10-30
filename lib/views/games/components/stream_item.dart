import 'package:flutter/cupertino.dart';
import 'package:twitch_clone/models/models.dart';
import 'package:twitch_clone/widgets/badge.dart';
import 'package:twitch_clone/widgets/widgets.dart';

class StreamItem extends StatelessWidget {
  final GameStream stream;

  StreamItem({this.stream, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Column(
      children: <Widget>[
        Stack(
          children: [
            Container(
              child: Image.network(stream.preview.large),
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
                label: '${stream.viewers} viewers',
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
                  stream.channel.logo,
                  // TODO Move to theme
                  borderColor: Color.fromARGB(255, 145, 70, 255),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(stream.channel.name),
                      Text(stream.channel.status),
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

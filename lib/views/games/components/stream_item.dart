import 'package:flutter/cupertino.dart';
import 'package:twitch_clone/models/models.dart';

class StreamItem extends StatelessWidget {
  final GameStream stream;

  StreamItem({this.stream, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Column(
              children: [
                Container(
                  child: Image.network(stream.thumbnailUrl),
                  width: width,
                ),
                Column(
                  children: [
                    Text(stream.userName),
                    Text(stream.title),
                  ],
                )
              ],
            ),
          ),
        ],
      )
    );
  }
}

import 'package:flutter/cupertino.dart';

class TagChip extends StatelessWidget {
  final String tag;
  final Color color;
  final Color labelColor;

  const TagChip({
    Key key,
    @required this.tag,
    @required this.color,
    this.labelColor = const Color.fromRGBO(0, 0, 0, 1),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(9.0),
      ),
      child: Text(
        tag,
        style: TextStyle(
          fontSize: 12.0,
          color: labelColor,
        ),
      ),
    );
  }
}

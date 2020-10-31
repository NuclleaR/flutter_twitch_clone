import 'package:flutter/widgets.dart';

class CircularImage extends StatelessWidget {
  final String imagePath;
  final Color borderColor;
  final double width;
  final double height;
  final BoxBorder border;

  CircularImage(this.imagePath,
      {Color borderColor = const Color.fromRGBO(0, 0, 0, 1),
      @required this.width,
      @required this.height,
      BoxBorder border})
      : this.borderColor = borderColor,
        this.border = border ??
            Border.all(
                color: borderColor, width: 3.0, style: BorderStyle.solid);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: new BoxDecoration(
          shape: BoxShape.circle,
          border: border,
          image: new DecorationImage(
              fit: BoxFit.cover, image: NetworkImage(imagePath))),
    );
  }
}

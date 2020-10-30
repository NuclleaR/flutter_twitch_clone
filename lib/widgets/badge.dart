import 'package:flutter/widgets.dart';

class Badge extends StatelessWidget {
  final Color color;
  final Color labelColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final String label;

  const Badge({
    Key key,
    @required this.color,
    @required this.label,
    this.borderRadius = 8.0,
    this.padding = const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
    this.labelColor = const Color.fromRGBO(0, 0, 0, 1),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Text(label, style: TextStyle(
        color: labelColor,
      )),
    );
  }
}

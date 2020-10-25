import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:twitch_clone/store/states.dart';

class TabsHeader extends SliverPersistentHeaderDelegate {
  final double _height = 32.0;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    var theme = context.read<AppSate>().theme;

    return Container(
      height: _height,
      decoration: BoxDecoration(
        color: theme.background,
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: CupertinoSlidingSegmentedControl(
        thumbColor: const Color.fromARGB(255, 145, 70, 255),
        groupValue: 1,
        children: {
          1: Text("One"),
          2: Text("Two"),
          3: Text("Three"),
        },
        onValueChanged: (value) {
          print(value);
        },
      ),
    );
  }

  @override
  double get maxExtent => _height;

  @override

  double get minExtent => _height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    print('TabsHeader oldDelegate');
    return true;
  }
}
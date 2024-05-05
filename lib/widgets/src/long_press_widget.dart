import 'package:flutter/widgets.dart';

class LongPressWidget extends StatelessWidget {

  final Widget child;
  final void Function() onLongPress;

  LongPressWidget({required this.child, required this.onLongPress});

  @override
  Widget build(BuildContext context) {
    // create widget
    Widget longPress = GestureDetector(onLongPress: () => onLongPress(), child: child,);
    return longPress;
  }//build
}//LongPressWidget
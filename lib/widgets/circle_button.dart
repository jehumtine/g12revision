import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  const CircularButton({
    Key? key,
  this.child,
    this.color,
    this.onTap,
    this.width = 60.0,
  }) : super(key: key);

  final Widget? child;
  final Color? color;
  final double width;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
        shape: const CircleBorder(),
        clipBehavior: Clip.hardEdge,
        type: MaterialType.transparency,
        child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: child,
            ))

   
        );
  }
}

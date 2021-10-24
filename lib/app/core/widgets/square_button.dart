import 'package:flutter/material.dart';

class SquareButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color? color;
  final double size;
  final EdgeInsets padding;
  final BorderRadiusGeometry borderRadius;

  const SquareButton({
    Key? key,
    required this.child,
    this.onPressed,
    this.size = 60,
    this.color,
    this.padding = const EdgeInsets.all(15.0),
    this.borderRadius = const BorderRadius.all(Radius.circular(12))
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 6.0,
      constraints: BoxConstraints.expand(width: this.size, height: this.size),
      fillColor: this.color ?? Theme.of(context).backgroundColor,
      child: child,
      padding: this.padding,
      shape: RoundedRectangleBorder(borderRadius: this.borderRadius),
      onPressed: this.onPressed,
    );
  }
}

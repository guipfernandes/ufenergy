import 'package:flutter/material.dart';

import 'loading_widget.dart';

class LoadingButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color? color;
  final bool loading;
  final Size size;
  final BorderRadiusGeometry borderRadius;

  const LoadingButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.color,
    this.loading = false,
    this.size = const Size(130, 50),
    this.borderRadius = const BorderRadius.all(Radius.circular(10))
  }) : super(key: key);

  @override
  _LoadingButtonState createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        child: widget.loading
            ? LoadingWidget(color: Colors.white, strokeWidth: 2.0, size: 20)
            : widget.child,
        style: ElevatedButton.styleFrom(
            primary: widget.color,
            shape: RoundedRectangleBorder(borderRadius: widget.borderRadius), fixedSize: widget.size),
        onPressed: () {
          if (!widget.loading) widget.onPressed();
        }
    );
  }
}

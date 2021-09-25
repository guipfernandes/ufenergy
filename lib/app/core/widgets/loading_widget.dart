import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final double size;
  final Color? color;
  final double strokeWidth;

  const LoadingWidget({
    Key? key,
    this.size = 35,
    this.color,
    this.strokeWidth = 4
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
          child: CircularProgressIndicator(
            color: color,
            strokeWidth: strokeWidth,
          ),
          width: size,
          height: size,
        )
    );
  }
}

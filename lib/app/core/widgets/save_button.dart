import 'package:flutter/material.dart';

import 'loading_widget.dart';

class SaveButton extends StatefulWidget {
  final VoidCallback onPressed;
  final bool loading;
  final Size size;
  final BorderRadiusGeometry borderRadius;

  const SaveButton({
    Key? key,
    required this.onPressed,
    this.loading = false,
    this.size = const Size(130, 50),
    this.borderRadius = const BorderRadius.all(Radius.circular(25))
  }) : super(key: key);

  @override
  _SaveButtonState createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        child: widget.loading
            ? LoadingWidget(color: Colors.white, strokeWidth: 2.0, size: 20)
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.check),
                  SizedBox(width: 8),
                  Text("Salvar")
                ],
              ),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: widget.borderRadius), fixedSize: widget.size),
        onPressed: () {
          if (!widget.loading) widget.onPressed();
        }
    );
  }
}

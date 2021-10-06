import 'package:flutter/material.dart';

import 'loading_button.dart';

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
    return LoadingButton(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.check),
            SizedBox(width: 8),
            Text("Salvar")
          ],
        ),
        loading: widget.loading,
        size: widget.size,
        borderRadius: widget.borderRadius,
        onPressed: widget.onPressed
    );
  }
}

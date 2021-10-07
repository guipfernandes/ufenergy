import 'package:flutter/material.dart';

class AppNameWidget extends StatelessWidget {
  final EdgeInsetsGeometry? margin;

  const AppNameWidget({Key? key, this.margin = const EdgeInsets.only(top: 16)}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: RichText(
        text: TextSpan(
          children: <TextSpan>[
            new TextSpan(text: 'UF', style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.bold)),
            new TextSpan(
                text: 'ener',
                style: Theme.of(context).textTheme.headline4!.copyWith(color: Theme.of(context).backgroundColor)),
            new TextSpan(text: 'G', style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.bold)),
            new TextSpan(
                text: 'y',
                style: Theme.of(context).textTheme.headline4!.copyWith(color: Theme.of(context).backgroundColor)),
          ],
        ),
      ),
    )
    ;
  }
}

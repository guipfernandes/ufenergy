import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize; // default is 56.0
  final String title;

  AppBarWidget({Key? key, this.title = ""}) : preferredSize = Size.fromHeight(kToolbarHeight), super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<AppBarWidget>{

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      centerTitle: true,
      leading: Icon(Icons.menu),
      actions: [
        SvgPicture.asset("assets/icons/logo.svg", height: 45,)
      ],
    );
  }
}
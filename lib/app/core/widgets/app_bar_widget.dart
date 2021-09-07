import 'package:flutter/material.dart';
import 'package:ufenergy/app/core/utils/asset_icons.dart';
import 'package:ufenergy/app/core/widgets/square_button.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  final String title;

  AppBarWidget({Key? key, this.title = ""}) : preferredSize = Size.fromHeight(75.0), super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<AppBarWidget>{

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: widget.preferredSize.height,
      iconTheme: Theme.of(context).iconTheme,
      title: FittedBox(
        fit: BoxFit.fitWidth,
        child: Text(widget.title),
      ),
      leading: Container(
        margin: EdgeInsets.only(left: 12, top: 10, right: 0, bottom: 10),
        child: SquareButton(
          child: Icon(
            Icons.menu,
          ),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      leadingWidth: 66,
      actions: [
        Image.asset(AssetIcons.logo, width: 50,)
      ],
    );
  }
}
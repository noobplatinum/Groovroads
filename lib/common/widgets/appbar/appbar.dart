import 'package:flutter/material.dart';
import 'package:groovroads/common/helpers/isdarkmode.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget{
  final Widget ? title;
  final Widget ? action;
  final bool ? hideBack;
  final Color ? backgroundColor;
  const Appbar({this.backgroundColor, this.title, super.key, this.hideBack = false, this.action});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: title ?? const Text(''),
      actions: [action ?? Container()],
      leading: (hideBack ?? false) ? null : IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Container(
          height: 50, width: 50,
          decoration: BoxDecoration(
            color: context.isDarkMode ? Colors.white.withOpacity(0.03) : Colors.black.withOpacity(0.04)),
          child: Icon(
            Icons.arrow_back_ios_new, size: 20, color: context.isDarkMode ? Colors.white : Colors.black,
          ),
        )
      )
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
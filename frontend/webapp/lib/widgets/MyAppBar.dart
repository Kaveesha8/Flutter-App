import 'package:flutter/material.dart';
 
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key, required this.title}) : super(key: key);
 
  final String title;
 
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      backgroundColor: Colors.teal,
      foregroundColor: Colors.white,
    );
  }
 
  @override
  Size get preferredSize => AppBar().preferredSize;
}
 
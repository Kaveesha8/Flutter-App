import 'package:flutter/material.dart';
 
class MyNavigationBar extends StatelessWidget {
  const MyNavigationBar({super.key, required this.title, required this.executeFunction});
  final String title;
  final void Function() executeFunction;
 
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        color: Colors.teal,
        textColor: Colors.white,
        padding: const EdgeInsets.all(20),
        onPressed: executeFunction,
        child: Text(title),
      );
  }
}
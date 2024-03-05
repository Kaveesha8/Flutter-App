import 'package:flutter/material.dart';
import 'package:webapp/api_handler.dart';
import 'package:webapp/models/model.dart';
import 'package:webapp/widgets/myAppBar.dart';
import 'package:webapp/widgets/myNavigationBar.dart';
 
class FindUser extends StatefulWidget {
  const FindUser({super.key});
 
  @override
  State<FindUser> createState() => _FindUserState();
}
 
class _FindUserState extends State<FindUser> {
  ApiHandler apiHandler = ApiHandler();
  User user = const User.empty();
  TextEditingController textEditingController = TextEditingController();
 
  void findUser(int userId) async {
    user = await apiHandler.getUserById(userId: userId);
    setState(() {});
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Find User'),
      bottomNavigationBar: MyNavigationBar(
        title: 'Find',
        executeFunction: () {
          findUser(int.parse(textEditingController.text));
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: textEditingController,
            ),
            const SizedBox(
              height: 10,
            ),
            if (user.id == 0) // Check if user ID is zero
              const Text('No user found',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
            else
              ListTile(
                leading: Text("${user.id}"),
                title: Text(user.name),
                subtitle: Text(user.addresss),
              )
          ],
        ),
      ),
    );
  }
}
 
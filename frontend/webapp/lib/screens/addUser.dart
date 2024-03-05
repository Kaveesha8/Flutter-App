import "package:flutter/material.dart";
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:webapp/api_handler.dart';
import 'package:webapp/models/model.dart';
import 'package:webapp/screens/main_page.dart';
import 'package:webapp/widgets/myAppBar.dart';
import 'package:webapp/widgets/myNavigationBar.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
 
class AddUser extends StatefulWidget {
  const AddUser({super.key});
 
  @override
  State<AddUser> createState() => _AddUserState();
}
 
class _AddUserState extends State<AddUser> {
  final _formKey = GlobalKey<FormBuilderState>();
  ApiHandler apiHandler = ApiHandler(); // create an instance of ApiHander class
 
 
  void addUser() async {
  if (_formKey.currentState!.saveAndValidate()) {
    final data = _formKey.currentState!.value;
    final name = data['name'] as String?;
    final address = data['address'] as String?;
   
    // Check if name or address is null or empty
    if (name == null || name.isEmpty || address == null || address.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Name and address are required.'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      final user = User(
        id: 0,
        name: name,
        addresss: address,
      );
      await apiHandler.addUser(user: user);
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()),
      ).then((value) => setState(() {}));
    }
  }
}
 
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Add User'),
      bottomNavigationBar:
          MyNavigationBar(title: 'Add', executeFunction: addUser),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'name',
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              const SizedBox(
                height: 10,
              ),
              FormBuilderTextField(
                name: 'address',
                keyboardType: TextInputType.streetAddress,
                decoration: const InputDecoration(labelText: 'Address'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
 
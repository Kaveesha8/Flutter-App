import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:webapp/api_handler.dart';
import 'package:webapp/models/model.dart';
import 'package:webapp/widgets/myAppBar.dart';
import 'package:webapp/widgets/myNavigationBar.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:http/http.dart' as http;
 
class EditPage extends StatefulWidget {
  const EditPage({super.key, required this.user});
 
  final User user;
 
  @override
  State<EditPage> createState() => _EditPageState();
}
 
class _EditPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  ApiHandler apiHandler = ApiHandler(); // create an instance of ApiHander class
  late http.Response response;
 
  void updateData() async {
    if (_formKey.currentState!.saveAndValidate()) {
      final data = _formKey.currentState!.value;
      final user = User(
        id: widget.user.id,
        name: data['name'],
        addresss: data['address'],
      );
      response = await apiHandler.updateUser(userId: widget.user.id, user: user);
    }
    if (!mounted)return;
    Navigator.pop(context);
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Edit Page'),
      bottomNavigationBar: MyNavigationBar(title: 'Update', executeFunction: updateData),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: FormBuilder(
          key: _formKey,
          initialValue: {
            'name': widget.user.name,
            'address': widget.user.addresss,
          },
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'name',
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
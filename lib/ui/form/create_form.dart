import 'package:flutter/material.dart';
import 'package:sqlite_form/models/user_model.dart';
import 'package:sqlite_form/services/form_db_helper.dart';
import 'package:sqlite_form/services/user_db.dart';
import 'package:sqlite_form/ui/form/const/const.dart';
import 'package:sqlite_form/ui/form/widgets/custom_text_field_widget.dart';
import 'package:sqlite_form/ui/form/widgets/custome_buttom_widget.dart';
import 'package:sqlite_form/ui/home/users_screen.dart';

class CreateFormScreen extends StatefulWidget {
  const CreateFormScreen({super.key});

  @override
  State<CreateFormScreen> createState() => _CreateFormScreenState();
}

class _CreateFormScreenState extends State<CreateFormScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UsersScreen()));
              },
              icon: Icon(Icons.people))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            // crossAxisAlignment: ,
            children: [
              Padding(
                padding: const EdgeInsets.all(50),
                child: Icon(Icons.create, size: 100, color: Colors.blueAccent),
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomeTextFieldForm(
                        hintText: "Enter your Name",
                        suffixIcon: Icons.person,
                        controller: Controllers.nameController,
                        validator: (value) => value!.trim().isEmpty
                            ? 'Enter Your Name'
                            : !Validate.nameRegExp.hasMatch(value)
                                ? "Enter a Valid Name"
                                : null,
                      ),
                      CustomeTextFieldForm(
                        validator: (String? value) {
                          if (value!.trim().isEmpty) {
                            return 'enter the Email';
                          } else if (!Validate.emailRegExp.hasMatch(value)) {
                            return 'enter vailid Email';
                          }
                          return null;
                        },
                        hintText: "Enter your Email",
                        suffixIcon: Icons.email,
                        controller: Controllers.emailController,
                      ),
                      CustomeTextFieldForm(
                        validator: (value) => value!.trim().isEmpty
                            ? 'Enter Your Phone Number'
                            : !Validate.phoneRegExp.hasMatch(value)
                                ? "Enter a Valid Phone Number"
                                : null,
                        hintText: "Phone Number",
                        suffixIcon: Icons.phone,
                        controller: Controllers.phoneController,
                      ),
                      CustomeTextFieldForm(
                        validator: (value) =>
                            value!.trim().isEmpty ? "Enter Your Adress" : null,
                        hintText: "Adress",
                        suffixIcon: Icons.location_on,
                        controller: Controllers.adressController,
                      ),
                    ],
                  )),
              CustomeButton(
                title: 'Create User',
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    createUser();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  _createUser() async {
    await DBHelper.createUser(
            name: Controllers.nameController.text.trim().toString(),
            phone: Controllers.phoneController.text.trim().toString(),
            email: Controllers.emailController.text.trim().toString(),
            adress: Controllers.adressController.text.trim().toString())
        .then((value) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => UsersScreen()));
    });
  }

  createUser() async {
    await UserDB.createUser(UserModel(
            name: Controllers.nameController.text.trim().toString(),
            phone: Controllers.phoneController.text.trim().toString(),
            email: Controllers.emailController.text.trim().toString(),
            adress: Controllers.adressController.text.trim().toString()))
        .then((value) => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => UsersScreen())));
  }
}

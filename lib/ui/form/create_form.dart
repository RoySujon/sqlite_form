import 'package:flutter/material.dart';
import 'package:sqlite_form/services/form_db_helper.dart';
import 'package:sqlite_form/ui/form/widgets/custom_text_field.dart';
import 'package:sqlite_form/ui/form/widgets/custome_buttom.dart';
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
                        controller: Controller.nameController,
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
                        controller: Controller.emailController,
                      ),
                      CustomeTextFieldForm(
                        validator: (value) => value!.trim().isEmpty
                            ? 'Enter Your Phone Number'
                            : !Validate.phoneRegExp.hasMatch(value)
                                ? "Enter a Valid Phone Number"
                                : null,
                        hintText: "Phone Number",
                        suffixIcon: Icons.phone,
                        controller: Controller.phoneController,
                      ),
                      CustomeTextFieldForm(
                        validator: (value) =>
                            value!.trim().isEmpty ? "Enter Your Adress" : null,
                        hintText: "Adress",
                        suffixIcon: Icons.location_on,
                        controller: Controller.adressController,
                      ),
                    ],
                  )),
              CustomeButton(
                title: 'Create User',
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    DBHelper.createUser(
                            name: Controller.nameController.text
                                .trim()
                                .toString(),
                            phone: Controller.phoneController.text
                                .trim()
                                .toString(),
                            email: Controller.emailController.text
                                .trim()
                                .toString(),
                            adress: Controller.adressController.text
                                .trim()
                                .toString())
                        .then((value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UsersScreen()));
                    });
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Controller {
  static final nameController = TextEditingController();
  static final emailController = TextEditingController();
  static final phoneController = TextEditingController();
  static final adressController = TextEditingController();
  static final idController = TextEditingController();
}

class Validate {
  static final RegExp nameRegExp = RegExp(r"^\b([A-ZÀ-ÿ][-,a-z. ']+[ ]*)+");
  static final RegExp emailRegExp = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
  static final RegExp phoneRegExp =
      RegExp(r"^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$");
}

import 'package:flutter/material.dart';
import 'package:sqlite_form/services/form_db_helper.dart';
import 'package:sqlite_form/ui/form/widgets/custom_text_field.dart';
import 'package:sqlite_form/ui/form/widgets/custome_buttom.dart';
import 'package:sqlite_form/ui/home/users_screen.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key, required this.id});
  final int id;
  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final _formKey = GlobalKey<FormState>();

  _getItem() async {
    var data = await DBHelper.getUser(id: widget.id);
    Controller.nameController.text = data[0]['name'].toString();
    Controller.emailController.text = data[0]['email'].toString();
    Controller.phoneController.text = data[0]['phone'].toString();
    Controller.adressController.text = data[0]['adress'].toString();
    setState(() {});
  }

  @override
  void initState() {
    _getItem();
    super.initState();
  }

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
                child: Icon(Icons.update, size: 100, color: Colors.blueAccent),
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
                title: 'Update User',
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    DBHelper.updateUser(
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
                                .toString(),
                            id: widget.id)
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

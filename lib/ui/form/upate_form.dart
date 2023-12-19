import 'package:flutter/material.dart';
import 'package:sqlite_form/models/user_model.dart';
import 'package:sqlite_form/services/user_db.dart';
import 'package:sqlite_form/ui/form/const/const.dart';
import 'package:sqlite_form/ui/form/widgets/custom_text_field_widget.dart';
import 'package:sqlite_form/ui/form/widgets/custome_buttom_widget.dart';
import 'package:sqlite_form/ui/home/users_screen.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key, required this.userModel});
  final UserModel userModel;
  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController adressController = TextEditingController();
  TextEditingController idController = TextEditingController();

  // @override
  // void initState() {
  //   Controllers.nameController.text = widget.userModel.name!.toString();
  //   Controllers.emailController.text = widget.userModel.email!.toString();
  //   Controllers.adressController.text = widget.userModel.adress!.toString();
  //   Controllers.phoneController.text = widget.userModel.phone!.toString();
  //   setState(() {});
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    nameController.text = widget.userModel.name!.toString();
    emailController.text = widget.userModel.email!.toString();
    adressController.text = widget.userModel.adress!.toString();
    phoneController.text = widget.userModel.phone!.toString();

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
                        controller: nameController,
                        validator: (value) => value!.trim().isEmpty
                            ? 'Enter Your Name'
                            : !Validate.nameRegExp.hasMatch(value)
                                ? "Enter a Valid Name"
                                : null,
                      ),
                      CustomeTextFieldForm(
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'enter the Email';
                          } else if (!Validate.emailRegExp.hasMatch(value)) {
                            return 'enter vailid Email';
                          }
                          return null;
                        },
                        hintText: "Enter your Email",
                        suffixIcon: Icons.email,
                        controller: emailController,
                      ),
                      CustomeTextFieldForm(
                        validator: (value) => value!.trim().isEmpty
                            ? 'Enter Your Phone Number'
                            : !Validate.phoneRegExp.hasMatch(value)
                                ? "Enter a Valid Phone Number"
                                : null,
                        hintText: "Phone Number",
                        suffixIcon: Icons.phone,
                        controller: phoneController,
                      ),
                      CustomeTextFieldForm(
                        validator: (value) =>
                            value!.trim().isEmpty ? "Enter Your Adress" : null,
                        hintText: "Adress",
                        suffixIcon: Icons.location_on,
                        controller: adressController,
                      ),
                    ],
                  )),
              CustomeButton(
                title: 'Update User',
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    await UserDB.updateUser(
                            UserModel(
                              // id: widget.userModel.id!.toInt(),
                              name: nameController.text.trim().toString(),
                              phone: phoneController.text.trim().toString(),
                              email: emailController.text.trim().toString(),
                              adress: adressController.text.trim().toString(),
                              createAt: DateTime.now().toString(),
                            ),
                            widget.userModel.id!.toInt())
                        .then((value) => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UsersScreen(),
                            )));
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

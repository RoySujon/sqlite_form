import 'package:flutter/material.dart';

class Controllers {
  static TextEditingController nameController = TextEditingController();
  static TextEditingController emailController = TextEditingController();
  static TextEditingController phoneController = TextEditingController();
  static TextEditingController adressController = TextEditingController();
  static TextEditingController idController = TextEditingController();
}

class Validate {
  static final RegExp nameRegExp = RegExp(r"^\b([A-ZÀ-ÿ][-,a-z. ']+[ ]*)+");
  static final RegExp emailRegExp = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
  static final RegExp phoneRegExp =
      RegExp(r"^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$");
}

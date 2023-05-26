import 'package:BikeX/core/app_export.dart';
import 'package:BikeX/presentation/auth/createNewPassword/create_new_password_con.dart';
import 'package:BikeX/presentation/commonWidgets/app_bar.dart';
import 'package:BikeX/presentation/commonWidgets/app_button.dart';
import 'package:BikeX/presentation/commonWidgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  CreateNewPasswordScreen({Key? key}) : super(key: key);
  final CreateNewPasswordController _con =
      Get.put(CreateNewPasswordController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(leading: "back", text: "Create New Password"),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              children: [
                SizedBox(height: Get.height * 0.05),
                SizedBox(
                  height: Get.height * 0.30,
                  child: Image.asset(
                    ImageConstant.newpassword,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: Get.height * 0.05),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    "Enter the email address associated with your account.",
                    style: TextStyle(
                      height: 1.4,
                      color: AppColors.subTextColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: Get.height * 0.05),
                AppTextField(
                  prefixIcon: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Image.asset(ImageConstant.password)),
                  suffixIcon: const Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Icon(
                      Icons.remove_red_eye_sharp,
                      color: Colors.grey,
                    ),
                  ),
                  hintText: "New Password",
                  obsecureText: false,
                  onChange: (value) {
                    _con.password.value = value.trim();
                    _con.passwordError.value = '';
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp("[a-zA-Z0-9@_.-]"),
                    ),
                  ],
                  errorMessage: _con.passwordError,
                ),
                SizedBox(height: Get.height * 0.028),
                AppTextField(
                  prefixIcon: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Image.asset(ImageConstant.password)),
                  suffixIcon: const Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Icon(
                      Icons.remove_red_eye_sharp,
                      color: Colors.grey,
                    ),
                  ),
                  hintText: "Conform Password",
                  obsecureText: false,
                  onChange: (value) {
                    _con.confirmPassword.value = value.trim();
                    _con.confirmPasswordError.value = '';
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp("[a-zA-Z0-9@_.-]"),
                    ),
                  ],
                  errorMessage: _con.confirmPasswordError,
                ),
                SizedBox(height: Get.height * 0.05),
                AppButton(
                  onPressed: () {
                    _con.onResetPassword();
                  },
                  width: Get.width / 2,
                  text: "Save",
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

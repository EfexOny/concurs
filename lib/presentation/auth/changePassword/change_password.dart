import 'package:BikeX/core/app_export.dart';
import 'package:BikeX/presentation/auth/changePassword/change_password_con.dart';
import 'package:BikeX/presentation/commonWidgets/app_bar.dart';
import 'package:BikeX/presentation/commonWidgets/app_button.dart';
import 'package:BikeX/presentation/commonWidgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);
  final ChangePasswordController _con = Get.put(ChangePasswordController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        leading: "back",
        // action: true,
        text: "Settings",
      ),
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
                    ImageConstant.changePassword,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: Get.height * 0.05),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    "Your new password must be different from previous used password.",
                    style: TextStyle(
                      height: 1.4,
                      color: AppColors.subTextColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 36),
                AppTextField(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Image.asset(ImageConstant.password),
                  ),
                  suffixIcon: const Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Icon(
                      Icons.remove_red_eye_sharp,
                      color: Colors.grey,
                    ),
                  ),
                  hintText: "Carent Password",
                  obsecureText: false,
                  onChange: (value) {
                    _con.currentPassword.value = value.trim();
                    _con.currentPasswordError.value = '';
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp("[a-zA-Z0-9@_.-]"),
                    ),
                  ],
                  errorMessage: _con.currentPasswordError,
                ),
                SizedBox(height: Get.height * 0.028),
                AppTextField(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Image.asset(ImageConstant.password),
                  ),
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
                    child: Image.asset(ImageConstant.password),
                  ),
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
                  text: "Save",
                  width: Get.width / 2,
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

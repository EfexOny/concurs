import 'package:BikeX/core/app_export.dart';
import 'package:BikeX/presentation/commonWidgets/app_bar.dart';
import 'package:BikeX/presentation/commonWidgets/app_button.dart';
import 'package:BikeX/presentation/commonWidgets/app_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'forgot_password_con.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);
  final ForgotPasswordController _con = Get.put(ForgotPasswordController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(leading: "back", text: "Forgot Password"),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Column(
              children: [
                const SizedBox(height: 30),
                SizedBox(
                  height: Get.height * 0.30,
                  child: Image.asset(
                    ImageConstant.forgotpassword,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: Get.height * 0.05),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    "Please enter your email address to receive a verification cord",
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
                      child: Image.asset(ImageConstant.email)),
                  hintText: "Email",
                  obsecureText: false,
                  onChange: (value) {
                    _con.email.value = value.trim();
                    _con.emailError.value = '';
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp("[a-zA-Z0-9@_.-]"),
                    ),
                  ],
                  errorMessage: _con.emailError,
                ),
                const SizedBox(height: 42),
                AppButton(
                  width: Get.width / 2,
                  text: "Send",
                  onPressed: () {
                    try {
                      FirebaseAuth.instance
                          .sendPasswordResetEmail(email: _con.email.value);
                    } catch (e) {
                      print(e);
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text(e.toString()),
                            );
                          });
                    }
                  },
                ),
                SizedBox(height: Get.height * 0.05),
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "Back to Login",
                    style: TextStyle(
                      color: AppColors.subTextColor,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

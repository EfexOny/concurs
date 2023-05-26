import 'package:BikeX/core/app_export.dart';
import 'package:BikeX/presentation/auth/login/login_con.dart';
import 'package:BikeX/presentation/commonWidgets/app_bar.dart';
import 'package:BikeX/presentation/commonWidgets/app_button.dart';
import 'package:BikeX/presentation/commonWidgets/app_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final LoginController _con = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Scaffold(
          appBar: appBar(
            text: "",
            leading: "back",
          ),
          body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: ConstrainedBox(
              constraints: constraints.copyWith(
                minHeight: constraints.maxHeight,
                maxHeight: double.infinity,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(child: Image.asset(ImageConstant.login)),
                            Text(
                              "Login",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: Get.height * 0.02),
                            Text(
                              'Welcome back!',
                              style: TextStyle(
                                color: AppColors.subTextColor,
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            SizedBox(height: Get.height * 0.05),
                            AppTextField(
                              prefixIcon: Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Image.asset(ImageConstant.email)),
                              hintText: "Email",
                              obsecureText: false,
                              onChange: (value) {
                                _con.email.value = value;
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp("[a-zA-Z0-9@_.-]"),
                                ),
                              ],
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
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
                              hintText: "Password",
                              obsecureText: false,
                              onChange: (value) {
                                _con.password.value = value;
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp("[a-zA-Z0-9@_.-]"),
                                ),
                              ],
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: Get.height * 0.01),
                            Row(
                              children: [
                                Container(
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Icon(
                                    Icons.check,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                Text(
                                  "  Remember me",
                                  style:
                                      TextStyle(color: AppColors.subTextColor),
                                ),
                                const Spacer(),
                                TextButton(
                                  onPressed: () {
                                    Get.toNamed(AppRoutes.forgotPasswordScreen);
                                  },
                                  child: Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : AppColors.primaryColor,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: Get.height * 0.05),
                            Center(
                              child: AppButton(
                                text: "Login",
                                width: Get.width / 2,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    try {
                                      FirebaseAuth.instance
                                          .signInWithEmailAndPassword(
                                            email: _con.email.value,
                                            password: _con.password.value,
                                          )
                                          .then((value) {
                                        Get.toNamed(AppRoutes.bottomBarScreen);
                                      });
                                    } catch (e) {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Text(
                                              "Invalid email or password",
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: Get.height * 0.03),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Get.height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => Get.toNamed(AppRoutes.signUpScreen),
                            child: Text(
                              "Don't Have an Account?".tr + ' ',
                              style: TextStyle(
                                color: Get.isDarkMode
                                    ? Colors.white54
                                    : Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Get.toNamed(AppRoutes.signUpScreen),
                            child: Text(
                              "Register",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                                color: AppColors.primaryColor,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height * 0.02),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

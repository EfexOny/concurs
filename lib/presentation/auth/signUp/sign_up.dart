import 'package:BikeX/core/app_export.dart';
import 'package:BikeX/presentation/auth/signUp/sign_up_con.dart';
import 'package:BikeX/presentation/commonWidgets/app_bar.dart';
import 'package:BikeX/presentation/commonWidgets/app_button.dart';
import 'package:BikeX/presentation/commonWidgets/app_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignupScreen extends StatelessWidget {
  final SignupController _con = Get.put(SignupController());
  SignupScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(text: "", leading: "back"),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Get.height * 0.03),
                  Center(child: Image.asset(ImageConstant.register)),
                  SizedBox(height: Get.height * 0.02),
                  Text(
                    "Register",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  SizedBox(height: Get.height * 0.01),
                  const Text(
                    'Register in by entering your account details.',
                    style: TextStyle(
                        color: Color(0xffA5A5A5),
                        fontSize: 15,
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(height: Get.height * 0.028),
                  AppTextField(
                    prefixIcon: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Image.asset(
                          ImageConstant.email,
                        )),
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
                  SizedBox(height: Get.height * 0.028),
                  AppTextField(
                    prefixIcon: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Image.asset(
                          ImageConstant.password,
                        )),
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
                  // SizedBox(height: Get.height * 0.01),
                  Row(
                    children: [
                      Obx(
                        () => GestureDetector(
                          onTap: () {
                            _con.tAc.value = !_con.tAc.value;
                          },
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(
                                    0.4,
                                  ),
                                  blurRadius: 1.20,
                                  offset: const Offset(0.5, 0.6),
                                ),
                              ],
                            ),
                            child: Transform.scale(
                              scale: 1.2,
                              child: Checkbox(
                                side: BorderSide(
                                    color: AppColors.containerBorderColor),
                                value: _con.tAc.value,
                                activeColor: AppColors.secondaryColor,
                                checkColor: AppColors.primaryColor,
                                onChanged: (value) =>
                                    _con.tAc.value = !_con.tAc.value,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "   I agree to the Terms of service",
                        style: TextStyle(
                            color: AppColors.subTextColor, fontSize: 10),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.termsConditionScreen);
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: Get.isDarkMode
                                ? Colors.white
                                : AppColors.primaryColor,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Obx(
                    () => _con.tcError.value.isEmpty
                        ? const SizedBox(height: 15)
                        : Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              _con.tcError.value,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                  ),
                  SizedBox(height: Get.height * 0.03),
                  Center(
                    child: AppButton(
                      onPressed: () async {
                        try {
                          final existingUser = await FirebaseFirestore.instance
                              .collection('users')
                              .where('email', isEqualTo: _con.email.value)
                              .limit(1)
                              .get();

                          if (existingUser.docs.isNotEmpty) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text("This email is already registered."),
                                );
                              },
                            );
                          } else {
                            await FirebaseFirestore.instance.collection('users').add({
                              'email': _con.email.value,
                            });

                            await FirebaseAuth.instance.createUserWithEmailAndPassword(
                              email: _con.email.value,
                              password: _con.password.value,
                            );

                            Get.toNamed(AppRoutes.bottomBarScreen);
                          }
                        } catch (error) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text("Failed to register. Please try again."),
                              );
                            },
                          );
                        }
                      },
                      text: "Register Now",
                      width: Get.width / 2,
                    ),
                  ),

                  SizedBox(height: Get.height * 0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        // onTap: () => Get.toNamed(AppRoutes.signUpScreen),
                        child: Text(
                          "Already Have an Account?".tr + ' ',
                          style: TextStyle(
                              color: Get.isDarkMode
                                  ? Colors.white54
                                  : Colors.black54,
                              fontSize: 12),
                        ),
                      ),
                      GestureDetector(
                        // onTap: () => Get.toNamed(AppRoutes.signUpScreen),
                        child: Text(
                          "Login",
                          style: TextStyle(
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
  }
}

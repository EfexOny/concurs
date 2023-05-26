import 'package:BikeX/core/app_export.dart';
import 'package:BikeX/core/plugins/otp/otp_field_style.dart';
import 'package:BikeX/core/plugins/otp/otp_text_field.dart';
import 'package:BikeX/core/plugins/otp/style.dart';
import 'package:BikeX/presentation/auth/otpScreen/otp_controller.dart';
import 'package:BikeX/presentation/commonWidgets/app_bar.dart';
import 'package:BikeX/presentation/commonWidgets/app_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({Key? key}) : super(key: key);
  final OtpController _con = Get.put(OtpController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(leading: "back", text: "Verify Your Email"),
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
                    ImageConstant.otp,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: Get.height * 0.05),
                Text(
                  "Please enter the 4 digit code sent to your gmail address",
                  style: TextStyle(
                    height: 1.4,
                    color: AppColors.subTextColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 36),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
                  child: OTPTextField(
                    length: 4,
                    width: Get.width * 0.9,
                    fieldWidth: 60,
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold),
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldStyle: FieldStyle.box,
                    keyboardType: TextInputType.number,
                    obscureText: false,
                    onChanged: (val) {
                      _con.otp.value = val;
                    },
                    onCompleted: (val) {
                      _con.otp.value = val;
                      if (kDebugMode) {
                        print("pin : - $val");
                      }
                    },
                    otpFieldStyle: OtpFieldStyle(
                      borderColor: AppColors.primaryColor,
                      backgroundColor: const Color(0xffE7F2F2),
                      focusBorderColor: AppColors.primaryColor,
                      enabledBorderColor: Colors.black45,
                      disabledBorderColor: Colors.red,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  "Re-send Code",
                  style: TextStyle(
                    fontSize: 12,
                    decoration: TextDecoration.underline,
                    color: AppColors.subTextColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 42),
                AppButton(
                  onPressed: () {
                    _con.onEnterOtp();
                  },
                  width: Get.width / 2,
                  text: "Verify",
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

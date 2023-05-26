import 'package:BikeX/core/app_export.dart';
import 'package:BikeX/core/utils/helper.dart';
import 'package:flutter/foundation.dart';

class ForgotPasswordController extends GetxController {
  RxString email = "".obs;
  RxString emailError = "".obs;

  bool valid() {
    RxBool isValid = true.obs;

    emailError.value = '';
    if (email.isEmpty) {
      emailError.value = "Please enter a valid email address";
      isValid.value = false;
    } else if (!Helper.isEmail(email.value)) {
      emailError.value = "Please enter a valid email address";
      isValid.value = false;
    }

    return isValid.value;
  }

  forgotPassword() {
    if (valid()) {
      Get.toNamed(AppRoutes.otpScreen);
    } else {
      if (kDebugMode) {
        print("Not valid");
      }
    }
  }
}

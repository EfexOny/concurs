import 'package:BikeX/core/app_export.dart';
import 'package:flutter/foundation.dart';

class CreateNewPasswordController extends GetxController {
  RxString password = "".obs;
  RxString passwordError = "".obs;
  RxString confirmPassword = "".obs;
  RxString confirmPasswordError = "".obs;

  bool valid() {
    RxBool isValid = true.obs;
    passwordError.value = '';
    if (password.isEmpty) {
      passwordError.value = "Please enter valid password";
      isValid.value = false;
    } else if (confirmPassword.isEmpty) {
      confirmPasswordError.value = "Please enter valid confirm password";
      isValid.value = false;
    } else if (password != confirmPassword) {
      confirmPasswordError.value = "Password doesn't match";
      isValid.value = false;
    }
    return isValid.value;
  }

  onResetPassword() {
    if (valid()) {
      Get.offAllNamed(AppRoutes.loginScreen);
    } else {
      if (kDebugMode) {
        print("Not valid");
      }
    }
  }
}

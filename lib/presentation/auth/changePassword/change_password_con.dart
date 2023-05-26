import 'package:BikeX/core/app_export.dart';
import 'package:BikeX/core/utils/helper.dart';
import 'package:flutter/foundation.dart';

class ChangePasswordController extends GetxController {
  RxString password = "".obs;
  RxString passwordError = "".obs;
  RxString currentPassword = "".obs;
  RxString currentPasswordError = "".obs;
  RxString confirmPassword = "".obs;
  RxString confirmPasswordError = "".obs;

  bool valid() {
    RxBool isValid = true.obs;
    passwordError.value = '';

    if (currentPassword.isEmpty) {
      currentPasswordError.value = "Please enter a valid password";
      isValid.value = false;
    } else if (!Helper.isPassword(currentPassword.value)) {
      currentPasswordError.value =
          "The password must contain at least six character";
      isValid.value = false;
    }
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

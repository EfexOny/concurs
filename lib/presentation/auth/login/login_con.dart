import 'package:BikeX/core/app_export.dart';
import 'package:BikeX/core/utils/helper.dart';
import 'package:flutter/foundation.dart';

class LoginController extends GetxController {
  RxString password = ''.obs;
  RxString passwordError = ''.obs;
  RxString email = ''.obs;
  RxString emailError = ''.obs;

  bool valid() {
    RxBool isValid = true.obs;
    emailError.value = '';
    passwordError.value = '';
    if (email.isEmpty) {
      emailError.value = "Please enter a valid email address";
      isValid.value = false;
    } else if (!Helper.isEmail(email.value)) {
      emailError.value = "Please enter a valid email address";
      isValid.value = false;
    }
    if (password.isEmpty) {
      passwordError.value = "Please enter a valid password";
      isValid.value = false;
    } else if (!Helper.isPassword(password.value)) {
      passwordError.value = "The password must contain at least six character";
      isValid.value = false;
    }
    return isValid.value;
  }

  login() {
    if (valid()) {
      Get.toNamed(AppRoutes.bottomBarScreen);
    } else {
      if (kDebugMode) {
        print("Not valid");
      }
    }
  }
}

import 'package:BikeX/core/app_export.dart';
import 'package:BikeX/core/utils/helper.dart';
import 'package:flutter/foundation.dart';

class SignupController extends GetxController {
  RxString email = ''.obs;
  RxString emailError = ''.obs;
  RxString password = "".obs;
  RxString passwordError = ''.obs;

  RxBool tAc = false.obs;
  RxString tcError = "".obs;

  bool valid() {
    RxBool isValid = true.obs;
    emailError.value = '';
    passwordError.value = '';
    tcError.value = "";
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

    if (!tAc.value) {
      tcError.value = "*Please accept Terms and Conditions to continue";
      isValid.value = false;
    }
    return isValid.value;
  }

  register() {
    if (valid()) {
      Get.toNamed(AppRoutes.bottomBarScreen);
    } else {
      if (kDebugMode) {
        print("Not valid");
      }
    }
  }
}

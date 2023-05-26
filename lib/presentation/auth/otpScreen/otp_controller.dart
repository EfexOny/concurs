import 'package:BikeX/core/app_export.dart';
import 'package:BikeX/core/utils/global.dart';

class OtpController extends GetxController {
  RxString otp = "".obs;

  onEnterOtp() {
    if (otp.value.isEmpty || otp.value.length > 4) {
      toast("Please enter valid otp");
    } else {
      Get.toNamed(AppRoutes.createNewPasswordScreen);
    }
  }
}

import 'package:BikeX/core/app_export.dart';

class MyProfileController extends GetxController {
  RxList<MyProfile> myProfileList = RxList([]);
}

class MyProfile {
  String? image;
  String? text;

  MyProfile({
    this.image,
    this.text,
  });
}

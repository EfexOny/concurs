import 'package:BikeX/core/app_export.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class MyDrawerController extends GetxController {
  ZoomDrawerController? zoomDrawerController;
  @override
  void onInit() {
    if (kDebugMode) {
      print("-------------------");
    }
    zoomDrawerController = ZoomDrawerController();
    super.onInit();
  }
}

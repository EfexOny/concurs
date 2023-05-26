import 'package:BikeX/core/app_export.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class BottomBarController extends GetxController {
  RxInt pageIndex = 0.obs;

  RxInt drawer = 0.obs;

  final ZoomDrawerController zoomDrawerController = ZoomDrawerController();

  List icons = [
    [ImageConstant.home, ImageConstant.activeHome],
    [ImageConstant.profile, ImageConstant.activeProfile]
  ];

  List drawerList = [
    ["Ride History", ImageConstant.history],
    ["Map", ImageConstant.city],
    ["Garbage", ImageConstant.location],
    ["Admin", ImageConstant.route],
  ];
}

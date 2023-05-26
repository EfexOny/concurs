import 'package:BikeX/core/app_export.dart';
import 'package:BikeX/presentation/drawer/drawer_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({Key? key}) : super(key: key);
  final MyDrawerController _con = Get.put(MyDrawerController());

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: _con.zoomDrawerController,
      borderRadius: 24,
      style: DrawerStyle.Style1,
      openCurve: Curves.fastOutSlowIn,
      disableGesture: false,
      mainScreenTapClose: false,
      slideWidth: MediaQuery.of(context).size.width * 0.65,
      duration: const Duration(milliseconds: 500),
      backgroundColor: Colors.white,
      showShadow: true,
      angle: 0.0,
      clipMainScreen: true,
      mainScreen: body(),
      menuScreen: Theme(
        data: ThemeData.dark(),
        child: const Scaffold(
          backgroundColor: Colors.indigo,
          body: Padding(
            padding: EdgeInsets.only(left: 25),
            child: Center(
              child: Text(
                'kkkk',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
      ),
    );
  }

  body() {
    return Container(
      height: 100,
      width: 100,
      color: Colors.amber,
      child: const Text(
        "Drawer",
        style: TextStyle(
            color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:BikeX/core/app_export.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

ZoomDrawerController zoomDrawerController = ZoomDrawerController();

AppBar appBar({
  Function()? onPressed,
  Function()? onTap,
  String? text,
  String leading = "",
  bool? action = false,
  String? actionIcon,
}) =>
    AppBar(
      centerTitle: false,
      backgroundColor: AppColors.secondaryColor,
      elevation: 0,
      leading: leading == "menu"
          ? Container(
              margin:
                  const EdgeInsets.only(left: 15, bottom: 2, right: 0, top: 2),
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(
                      1.0,
                      1.0,
                    ),
                    blurRadius: 10.0,
                    spreadRadius: 2.0,
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: Colors.white,
              ),
              child: GestureDetector(
                  onTap: onTap, child: Image.asset(ImageConstant.menu)),
            )
          : leading == "back"
              ? Container(
                  margin: const EdgeInsets.only(
                      left: 15, bottom: 2, right: 0, top: 2),
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(
                          1.0,
                          1.0,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    color: Colors.white,
                  ),
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: AppColors.primaryColor,
                    ),
                  ),
                )
              : null,
      title: Text(
        text!,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w800,
          color: Colors.black,
        ),
      ),
      actions: [
        if (action!)
          GestureDetector(
            onTap: onPressed,
            child: Container(
              margin: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(
                        1.0,
                        1.0,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: actionIcon == null ? Container() : Image.asset(actionIcon),
            ),
          ),
        const SizedBox(
          width: 15,
        )
      ],
    );

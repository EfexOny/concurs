import 'package:BikeX/presentation/commonWidgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

logoutDialog(
        {@required String? title,
        @required String? description,
        @required Color? color,
        Function? onTap,
        context}) =>
    showDialog(
      barrierColor: const Color.fromRGBO(0, 0, 0, 0.80),
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          child: SizedBox(
            height: 150,
            child: Column(
              children: [
                msgArea(title, description, context),
                const Spacer(),
                footer(context, color, onTap)
              ],
            ),
          ),
        );
      },
    );

headerBar(color) => Container(
      color: color,
      height: 8.0,
    );

msgArea(title, description, context) => Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: double.infinity),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );

footer(context, color, onTap) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(8.0),
          bottomRight: Radius.circular(8.0),
        ),
        color: Colors.grey[100],
      ),
      child: AppButton(
        onPressed: onTap,
        text: "Log Out",
        width: Get.width / 2,
      ),
    );

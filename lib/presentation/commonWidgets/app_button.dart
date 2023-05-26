import 'package:flutter/material.dart';
import 'package:BikeX/core/app_export.dart';

class AppButton extends StatelessWidget {
  final Function()? onPressed;
  final String? text;
  final double? height;
  final double? width;

  const AppButton({
    Key? key,
    this.onPressed,
    this.text,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Colors.transparent,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Ink(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.primaryColor),
        child: Container(
          constraints: BoxConstraints(
            minHeight: height == null ? 40.0 : 30,
            maxHeight: height == null ? 50.0 : 40,
          ),
          width: width,
          alignment: Alignment.center,
          child: Text(
            text!,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:BikeX/core/utils/app_color.dart';

class AppDecoration {
  static get containerDecoration => BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      );
}

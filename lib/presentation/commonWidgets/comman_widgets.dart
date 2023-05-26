import 'package:BikeX/core/app_export.dart';
import 'package:flutter/material.dart';

Text commanTitle({String? text}) {
  return Text(
    text!,
    style: const TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
  );
}

Padding heading(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    child: Text(
      text,
      style: TextStyle(
        color: AppColors.subTextColor,
      ),
    ),
  );
}

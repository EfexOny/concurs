import 'dart:ui';
import 'package:flutter/material.dart';

class AppColors {
  static Color primaryColor = fromHex('#00af54');
  static Color secondaryColor = fromHex('#F8F8F8');
  static Color containerBorderColor = fromHex('#CCCCCC');
  static Color subTextColor = fromHex('#7F7F7F');

  static Color buttonTextColor = fromHex('#623B82');
  static Color lightBlue = fromHex('#00af54');
  static Color cyanColor = fromHex('#00af54');
  static Color gradient1 = fromHex('#22B0FF');
  static Color gradient2 = fromHex('#ABFEBA');
  static Color greenColor = fromHex('#00af54');
  static Color yellowColor = fromHex('#F7E584');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

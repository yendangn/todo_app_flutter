import 'package:flutter/material.dart';

class AppColor {
  // Define color.
  static var black = HexColor('#000000');
  static var white = HexColor('#FFFFFF');
  static var whiteOpacity = HexColor('#A6FFFFFF');
  static var blackOpacity = HexColor('#A6000000');
  static var mainColor = HexColor('#1B78AA');
  static var appScreenBackground = HexColor('#F2F3F3');
  static var tabInActiveColor = HexColor('#B8B8B8');
  static var grayButtonColor = HexColor('#B8B8B8');
  static var tabActiveColor = HexColor('#1B78AA');
  static var errorColor = HexColor('#BF2928');
  static var successColor = HexColor('#67CB4F');
  static var confirmColor = HexColor('#C9A100');
  static var inputGrayColor = HexColor('#707070');
  static var lineGayColor = HexColor('#707070');
}

// Parse hex to color.
class HexColor extends Color {
  static int _getColorFromHex(hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(value) : super(_getColorFromHex(value));
}

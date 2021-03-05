import 'package:flutter/material.dart';
import 'package:todoapp/resources/app_color.dart';

class AppStyle {
  static var appTheme = ThemeData(
    primaryColor: AppColor.mainColor,
    accentColor: AppColor.mainColor,
    scaffoldBackgroundColor: AppColor.appScreenBackground,
    platform: TargetPlatform.iOS,
    errorColor: AppColor.errorColor,
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.white,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
    ),
    buttonTheme: ButtonThemeData(
      padding: EdgeInsets.all(10),
      minWidth: double.infinity,
      buttonColor: AppColor.mainColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),
  );
}

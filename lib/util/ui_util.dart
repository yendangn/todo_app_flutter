import 'package:flutter/material.dart';
import 'package:todoapp/localization/app_translations.dart';
import 'package:todoapp/resources/app_color.dart';

class UiUtil {
  static Widget buildLine() {
    return Container(
      width: double.infinity,
      height: 0.2,
      color: AppColor.lineGayColor,
    );
  }

  static String getStringFromRes(String key, BuildContext context) =>
      AppTranslations.of(context).text(key);
}

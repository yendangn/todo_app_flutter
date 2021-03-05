import 'package:flutter/material.dart';
import 'package:todoapp/resources/app_dimen.dart';
import 'package:todoapp/resources/app_drawable.dart';
import 'package:todoapp/resources/app_font.dart';
import 'package:todoapp/resources/app_lang.dart';
import 'package:todoapp/util/ui_util.dart';
import 'package:todoapp/widget/app_button_widget.dart';

class AppErrorWidget extends StatelessWidget {
  final VoidCallback onRetry;

  AppErrorWidget({this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(
            image: AssetImage(AppDrawable.bg_error),
            width: 250,
            height: 200,
          ),
          SizedBox(
            height: AppDimen.app_margin,
          ),
          Text(
            UiUtil.getStringFromRes(AppLang.common_error_message, context),
            style: TextStyle(
              fontSize: 16,
              fontFamily: AppFont.nunito_regular,
            ),
          ),
          SizedBox(
            height: AppDimen.app_margin,
          ),
          SizedBox(
            width: 250,
            child: AppOutlineButtonWidget(
              label: UiUtil.getStringFromRes(AppLang.common_re_try, context),
              onPressed: onRetry,
            ),
          ),
        ],
      ),
    );
  }
}

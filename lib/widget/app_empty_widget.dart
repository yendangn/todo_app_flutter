import 'package:flutter/material.dart';
import 'package:todoapp/resources/app_dimen.dart';
import 'package:todoapp/resources/app_drawable.dart';
import 'package:todoapp/resources/app_font.dart';
import 'package:todoapp/resources/app_lang.dart';
import 'package:todoapp/util/ui_util.dart';
import 'package:todoapp/widget/app_button_widget.dart';

class AppEmptyWidget extends StatelessWidget {
  final String emptyMessage;
  final VoidCallback onRefresh;
  final String retryLabel;

  AppEmptyWidget({
    this.emptyMessage,
    this.onRefresh,
    this.retryLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(
            image: AssetImage(AppDrawable.bg_empty),
            width: 200,
            height: 200,
          ),
          SizedBox(
            height: AppDimen.app_margin,
          ),
          Text(
            emptyMessage,
            textAlign: TextAlign.center,
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
              label: retryLabel ??
                  UiUtil.getStringFromRes(AppLang.common_re_try, context),
              onPressed: onRefresh,
            ),
          ),
        ],
      ),
    );
  }
}

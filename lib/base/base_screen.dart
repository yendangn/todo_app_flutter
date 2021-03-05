import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:todoapp/base/base_viewmodel.dart';
import 'package:todoapp/localization/app_translations.dart';
import 'package:todoapp/resources/app_color.dart';
import 'package:todoapp/resources/app_font.dart';
import 'package:todoapp/type/view_state.dart';
import 'package:todoapp/widget/app_empty_widget.dart';
import 'package:todoapp/widget/app_error_widget.dart';
import 'package:todoapp/widget/app_loading_widget.dart';
import 'package:todoapp/widget/dialog/error_dialog_widget.dart';
import 'package:todoapp/widget/dialog/success_dialog_widget.dart';

abstract class BaseScreen<T extends StatefulWidget> extends State<T> {
  String getStringFromRes(String key) => AppTranslations.of(context).text(key);

  Widget buildEmptyView(String message, VoidCallback onRefresh,
      {String retryLabel}) {
    return AppEmptyWidget(
      emptyMessage: message,
      onRefresh: onRefresh,
      retryLabel: retryLabel,
    );
  }

  Widget buildRefreshView(
    Widget child,
    RefreshController refreshController,
    VoidCallback onRefresh, {
    VoidCallback onLoadMore,
  }) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: onLoadMore != null,
      controller: refreshController,
      onRefresh: onRefresh,
      onLoading: onLoadMore,
      header: WaterDropMaterialHeader(
        backgroundColor: AppColor.mainColor,
      ),
      footer: ClassicFooter(
        textStyle: TextStyle(
          fontFamily: AppFont.nunito_bold,
          fontSize: 14,
        ),
        loadingIcon: SpinKitThreeBounce(
          color: AppColor.mainColor,
          size: 30,
        ),
        loadingText: '',
      ),
      child: child,
    );
  }

  Widget buildContainerViewByStatus(
    BaseViewModel viewModel,
    Widget contentView,
    VoidCallback onRetry,
  ) {
    Widget mainView = Container();

    switch (viewModel.viewState) {
      case ViewState.Idle:
        mainView = Container();
        break;

      case ViewState.Loading:
        mainView = AppLoadingWidget();
        break;

      case ViewState.Loaded:
      case ViewState.Refreshing:
        mainView = contentView;
        break;

      case ViewState.Error:
        mainView = AppErrorWidget(onRetry: onRetry);
    }

    return mainView;
  }

  void showErrorDialog({
    String title,
    String content,
    VoidCallback onRetry,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) => ErrorDialogWidget(
        title: title,
        content: content,
        onClose: onRetry,
      ),
    );
  }

  void showSuccessDialog({
    String title,
    String content,
    bool barrierDismissible = true,
    VoidCallback onClose,
  }) {
    showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (BuildContext context) => SuccessDialogWidget(
        title: title,
        content: content,
        onClose: onClose,
      ),
    );
  }
}

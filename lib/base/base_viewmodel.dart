import 'package:flutter/widgets.dart';
import 'package:todoapp/type/view_state.dart';

class BaseViewModel extends ChangeNotifier {
  ViewState _viewState = ViewState.Idle;
  String _errorMsg;

  ViewState get viewState => _viewState;

  String get errorMsg => _errorMsg;

  void setViewState(ViewState newState) {
    _viewState = newState;
    notifyListeners();
  }

  void startLoading() {
    setViewState(ViewState.Loading);
  }

  void startRefreshing() {
    setViewState(ViewState.Refreshing);
  }

  void stopLoading() {
    setViewState(ViewState.Loaded);
  }

  void notifyError() {
    setViewState(ViewState.Error);
  }
}

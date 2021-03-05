import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:route_annotation/route_annotation.dart';
import 'package:todoapp/base/di/locator.dart';
import 'package:todoapp/feature/task_share_viewmodel.dart';
import 'package:todoapp/localization/app_translations_delegate.dart';
import 'package:todoapp/localization/application.dart';

import 'main.route.dart';
import 'resources/app_style.dart';

// Init lib here: locator, lang ...
void main() async => {
      setUpInjector(),
      Provider.debugCheckInvalidValueType = null,
      runApp(
        App(),
      ),
    };

@router
class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  AppTranslationsDelegate _newLocaleDelegate;
  Key key = UniqueKey();

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _newLocaleDelegate =
        AppTranslationsDelegate(newLocale: Locale(EN_CODE, 'English'));
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskShareViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppStyle.appTheme,
        key: key,
        initialRoute: ROUTE_HOME,
        onGenerateRoute: onGenerateRoute,
        localizationsDelegates: [
          _newLocaleDelegate,
          //provides localised strings
          GlobalMaterialLocalizations.delegate,
          //provides RTL support
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale(EN_CODE, ''),
          const Locale(VN_CODE, ''),
        ],
      ),
    );
  }
}

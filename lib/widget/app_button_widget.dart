import 'package:flutter/material.dart';
import 'package:todoapp/resources/app_color.dart';
import 'package:todoapp/resources/app_font.dart';

class AppButtonWidget extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color;

  AppButtonWidget({
    @required this.label,
    @required this.onPressed,
    this.color,
  });

  @override
  _AppButtonWidgetState createState() => _AppButtonWidgetState();
}

class _AppButtonWidgetState extends State<AppButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        color: widget.color ?? AppColor.mainColor,
        padding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        child: Text(
          widget.label.toUpperCase(),
          style: TextStyle(
            color: AppColor.white,
            fontSize: 15,
            fontFamily: AppFont.nunito_extra_bold,
          ),
        ),
        onPressed: widget.onPressed,
      ),
    );
  }
}

class AppOutlineButtonWidget extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color;

  AppOutlineButtonWidget({
    @required this.label,
    @required this.onPressed,
    this.color,
  });

  @override
  _AppOutlineButtonWidgetState createState() => _AppOutlineButtonWidgetState();
}

class _AppOutlineButtonWidgetState extends State<AppOutlineButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: OutlineButton(
        color: widget.color ?? AppColor.mainColor,
        padding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        child: Text(
          widget.label.toUpperCase(),
          style: TextStyle(
            color: widget.color ?? AppColor.mainColor,
            fontSize: 15,
            fontFamily: AppFont.nunito_extra_bold,
          ),
        ),
        onPressed: widget.onPressed,
      ),
    );
  }
}

class AppFlatButtonWidget extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color;

  AppFlatButtonWidget({
    @required this.label,
    @required this.onPressed,
    this.color,
  });

  @override
  _AppFlatButtonWidgetState createState() => _AppFlatButtonWidgetState();
}

class _AppFlatButtonWidgetState extends State<AppFlatButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        padding: const EdgeInsets.all(10),
        child: Text(
          widget.label,
          style: TextStyle(
            fontSize: 15,
            fontFamily: AppFont.nunito_extra_bold,
            color: widget.color ?? AppColor.black,
          ),
        ),
        onPressed: widget.onPressed,
      ),
    );
  }
}

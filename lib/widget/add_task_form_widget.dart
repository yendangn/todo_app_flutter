import 'package:flutter/material.dart';
import 'package:todoapp/resources/app_color.dart';
import 'package:todoapp/resources/app_lang.dart';
import 'package:todoapp/util/ui_util.dart';
import 'package:todoapp/util/validate_util.dart';

class AddTaskFormWidget extends StatefulWidget {
  final Function(String) onSubmitData;

  AddTaskFormWidget({
    this.onSubmitData,
    Key key,
  }) : super(key: key);

  @override
  AddTaskFormWidgetState createState() => AddTaskFormWidgetState();
}

class AddTaskFormWidgetState extends State<AddTaskFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        autovalidateMode: AutovalidateMode.always,
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(12),
                suffixIconConstraints: BoxConstraints(
                  minHeight: 0,
                ),
                isDense: true,
                labelText: UiUtil.getStringFromRes(AppLang.task_name, context),
                border: UnderlineInputBorder(),
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColor.inputGrayColor, width: 0.0),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(
                    color: AppColor.inputGrayColor,
                  ),
                ),
              ),
              onSaved: (name) {
                _name = name;
              },
              validator: _validatePhone,
            ),
          ],
        ),
      ),
    );
  }

  String _validatePhone(String phone) {
    if (ValidateUtil.isNullOrEmpty(phone)) {
      return UiUtil.getStringFromRes(AppLang.error_task_name_empty, context);
    }

    return null;
  }

  void validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if (widget.onSubmitData != null) {
        widget.onSubmitData(_name);
      }
    } else {
      setState(() {});
    }
  }
}
